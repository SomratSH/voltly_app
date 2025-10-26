import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voltly_app/common/custom_padding.dart';
import 'package:voltly_app/common/primary_button.dart';
import 'package:voltly_app/constant/app_colors.dart';
import 'package:voltly_app/presentation/station_owner/profile/subscription/subscription_provider.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SubscriptionProvider()..getSubscriptionData(),
      child: _Layout(),
    );
  }
}

class _Layout extends StatelessWidget {
  const _Layout({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SubscriptionProvider>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF121C24),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Subscription',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: provider.isLoading
          ? Center(child: CircularProgressIndicator())
          : provider.subscriptionList.isEmpty
          ? Center(child: Text("No Plan Data Available"))
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Choose Your Hosting Plan',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Upgrade your plan to get more visibility and manage\nyour chargers better.',
                    style: TextStyle(color: Color(0xFF888888), fontSize: 14),
                  ),
                  const SizedBox(height: 24),
                  Column(
                    children: List.generate(provider.subscriptionList.length, (
                      index,
                    ) {
                      final subscriptionData = provider.subscriptionList[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: _buildPlanCard(
                          title: subscriptionData.name!,
                          subtitle:
                              "${subscriptionData.price}/${subscriptionData.billingCycle}",
                          features: [
                            {'text': '1 charger listing', 'isIncluded': true},
                            {
                              'text': 'Standard placement in search',
                              'isIncluded': true,
                            },
                            {
                              'text': 'No analytics or premium visibility',
                              'isIncluded': false,
                            },
                          ],
                          buttonText: 'Upgrade to ${subscriptionData.name}',
                          isMostPopular: false,
                          isBestForBusiness: false,
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 16),
                  _buildInfoCard(),
                  const SizedBox(height: 24),
                  const Text(
                    'Billing',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildBillingCard(),
                  const SizedBox(height: 24),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'All subscriptions are billed securely via Stripe. Cancel anytime.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF6B7280),
                        fontSize: 12,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                        height: 1.67,
                      ),
                    ),
                  ),
                  vPad15,
                ],
              ),
            ),
    );
  }

  Widget _buildPlanCard({
    required String title,
    required String subtitle,
    String? subtitleNote,
    required List<Map<String, dynamic>> features,
    required String buttonText,
    required bool isMostPopular,
    required bool isBestForBusiness,
  }) {
    Color cardColor = isMostPopular || isBestForBusiness
        ? const Color(0xFF2E5431)
        : const Color(0xFF282828);
    Color buttonColor = isMostPopular || isBestForBusiness
        ? primaryColor
        : const Color(0xFF333333);
    Color buttonTextColor = isMostPopular || isBestForBusiness
        ? Colors.white
        : const Color(0xFF888888);

    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: ShapeDecoration(
        color: const Color(0xFF1F2937),
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: const Color(0xFF374151)),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          vPad10,
          if (isMostPopular)
            Positioned(
              top: -30,
              left: 0,

              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'Most Popular',
                    style: TextStyle(color: Colors.black, fontSize: 12),
                  ),
                ),
              ),
            ),
          if (isBestForBusiness)
            Positioned(
              top: -30,
              left: 0,

              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'Best for Business',
                    style: TextStyle(color: Colors.black, fontSize: 12),
                  ),
                ),
              ),
            ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: isMostPopular || isBestForBusiness
                          ? Colors.white
                          : const Color(0xFF6AB04A),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (subtitleNote != null)
                    Text(
                      subtitleNote,
                      style: const TextStyle(
                        color: Color(0xFF888888),
                        fontSize: 14,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 16),
              ...features.map((feature) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    children: [
                      Icon(
                        feature['isIncluded'] ? Icons.check : Icons.close,
                        color: feature['isIncluded']
                            ? primaryColor
                            : Colors.red,
                        size: 16,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          feature['text'],
                          style: TextStyle(
                            color: feature['isIncluded']
                                ? Colors.white
                                : const Color(0xFF888888),
                            decoration: feature['isIncluded']
                                ? TextDecoration.none
                                : TextDecoration.lineThrough,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: PrimaryButton(text: buttonText, onPressed: () {}),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: ShapeDecoration(
        color: const Color(0xFF1F2937),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Icon(Icons.wash, color: Color(0xFF6AB04A), size: 24),
          SizedBox(width: 16),
          Expanded(
            child: Text(
              'A host with 3+ stations might gladly pay \$29.99/month if it boosts bookings.',
              style: TextStyle(
                color: const Color(0xFFD1D5DB),
                fontSize: 14,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
                height: 1.64,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBillingCard() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: ShapeDecoration(
        color: const Color(0xFF1F2937),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Column(
        children: [
          Row(
            children: const [
              Icon(Icons.credit_card, color: Color(0xFF6AB04A), size: 24),
              SizedBox(width: 16),
              Text(
                'Payment via Stripe only',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: DecoratedBox(
              decoration: ShapeDecoration(
                color: Colors.black.withValues(alpha: 0),
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: const Color(0xFFE5E7EB)),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Manage Billing',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
