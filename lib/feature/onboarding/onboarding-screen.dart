// feature/onboarding/onboarding-screen.dart
class OnboardingPage extends StatelessWidget {
  final String image;
  final String title;
  final String desc;

  const OnboardingPage({
    super.key,
    required this.image,
    required this.title,
    required this.desc,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // تأكدي إن الصورة موجودة في الـ pubspec.yaml
          Image.asset(image, height: 250),
          const SizedBox(height: 30),
          Text(
            title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            desc,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController controller = PageController();
  int currentIndex = 0;

  // تعريف القائمة بشكل صريح لتجنب مشاكل الـ Null Safety
  final List<Map<String, String>> pages = [
    {
      "image": "assets/onboarding.png",
      "title": "Gain total control of your money",
      "desc": "Become your own money manager and make every penny count."
    },
    {
      "image": "assets/onboarding2.png", // مثال لصفحة تانية
      "title": "Know where your money goes",
      "desc": "Track your transaction easily, with categories and financial report."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: controller,
              itemCount: pages.length,
              onPageChanged: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemBuilder: (context, index) {
                return OnboardingPage(
                  // هنا استخدمنا toString() أو ! لضمان عدم وجود Null
                  image: pages[index]["image"]!,
                  title: pages[index]["title"]!,
                  desc: pages[index]["desc"]!,
                );
              },
            ),
          ),

          // زرار Get Started
          Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              width: double.infinity,
              height: 56, // طول مناسب للزرار
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/home');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF7F3DFF), // اللون البنفسجي اللي في الفيجما
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  "Get Started",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}