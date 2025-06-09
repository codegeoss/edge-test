import 'package:flutter/material.dart';

class NewDashboardScreen extends StatelessWidget {
  const NewDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            _buildTopSection(size),
            Positioned(
              top: size.height * 0.2,
              left: 20,
              right: 20,
              child: _buildWalletSection(),
            ),
            Padding(
              padding: EdgeInsets.only(top: size.height * 0.35),
              child: Column(
                children: [
                  _buildQuickServices(),
                  _buildLastTransactions(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopSection(Size size) {
    return Container(
      height: size.height * 0.3,
      color: Colors.blue.shade900,
      padding: const EdgeInsets.only(left: 20, right: 20, top: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Row(
            children: [
              const Icon(Icons.dashboard, size: 20, color: Colors.white),
              const Spacer(),
              _buildTopIcon(Icons.notifications_on_outlined),
              const SizedBox(width: 10),
              _buildTopIcon(Icons.menu_outlined),
            ],
          ),
          SizedBox(height: size.height * 0.04),
          const Text(
            'Hello Tshitshi',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ],
      ),
    );
  }

  Widget _buildTopIcon(IconData icon) {
    return CircleAvatar(
      radius: 20,
      backgroundColor: Colors.white,
      child: Icon(icon, color: Colors.black),
    );
  }

  Widget _buildWalletSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildWalletTab('USD Wallet', isActive: true),
              _buildWalletTab('FC Wallet'),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hide your Balance',
                    style: TextStyle(
                      color: Colors.blue.shade900,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    r'$10,000.00',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade900,
                    ),
                  ),
                ],
              ),
              FloatingActionButton(
                shape: const CircleBorder(),
                onPressed: () {},
                backgroundColor: Colors.amber,
                child: const Icon(Icons.add),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWalletTab(String title, {bool isActive = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isActive ? Colors.blue.shade900 : Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: isActive ? Colors.white : Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildQuickServices() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          _buildSectionTitle('Quick Services', 'View more'),
          GridView.count(
            padding: const EdgeInsets.only(top: 20),
            shrinkWrap: true,
            crossAxisCount: 4,
            children: [
              _buildServiceIcon(Icons.send, 'Send Money'),
              _buildServiceIcon(Icons.payment, 'Pay Bills'),
              _buildServiceIcon(Icons.phone_android, 'Buy Airtime'),
              _buildServiceIcon(Icons.atm, 'Withdraw'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildServiceIcon(IconData icon, String label) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: Colors.blue.shade100,
          child: Icon(icon, color: Colors.blue.shade900),
        ),
        const SizedBox(height: 5),
        Text(
          label,
          style: TextStyle(fontSize: 12, color: Colors.blue.shade900),
        ),
      ],
    );
  }

  Widget _buildLastTransactions() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Last Transactions', 'View history'),
          const SizedBox(height: 10),
          Column(
            children: List.generate(4, (index) => _buildTransactionTile()),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, String action) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(
          action,
          style: TextStyle(
            color: Colors.blue.shade900,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildTransactionTile() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 0,
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        leading: CircleAvatar(
          backgroundColor: Colors.red.shade100,
          child: const Icon(Icons.account_balance_wallet, color: Colors.red),
        ),
        title: const Text(
          '+243 123456789',
          style: TextStyle(color: Colors.black, fontSize: 15),
        ),
        subtitle: const Text(
          '12 Feb 2025',
          style: TextStyle(color: Colors.grey, fontSize: 12),
        ),
        trailing: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              r'$10,000',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            Text('-0.06%', style: TextStyle(color: Colors.red)),
          ],
        ),
      ),
    );
  }
}
