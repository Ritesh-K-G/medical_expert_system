import 'package:flutter/material.dart';
import 'package:medical_expert_system/constants.dart';

class Credits extends StatelessWidget {
  final List<Map<String, String>> contributors = [
    {
      'name': 'Prof. Vrijendra Singh',
      'designation': 'Professor, IIIT Allahabad',
      'contribution': 'Provided invaluable guidance and expertise in shaping the project\'s design and development. Assisted with validating medical datasets and ensured that the algorithms met academic standards. Offered continuous feedback and supervised the overall project progress.',
      'image': 'assets/images/Vrijendra_sir.png',
    },
    {
      'name': 'Trapti Shrivastava',
      'designation': 'PhD Student, IIIT Allahabad',
      'contribution': 'Assisted with the technical implementation and debugging of the project. Provided crucial support in understanding complex algorithms, reviewing code, and ensuring that the project met all technical requirements. Offered guidance during the development process and helped troubleshoot key issues.',
      'image': 'assets/images/Trapti_mam.jpeg',
    },
    {
      'name': 'Ashok Yadav',
      'designation': 'PhD Student, IIIT Allahabad',
      'contribution': 'Offered timely advice and valuable feedback throughout the project. Provided constant motivation and guidance, helping us navigate challenges and improve various aspects of the project. His insights on different approaches and techniques were invaluable to the successful completion of the project.',
      'image': 'assets/images/Ashok_sir.png',
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios, size: 24.0),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(width: 5),
                  const Text('Credits Screen', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),)
                ],
              ),
            ),
            Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView.builder(
                    itemCount: contributors.length,
                    itemBuilder: (context, index) {
                      final contributor = contributors[index];
                      return Card(
                        elevation: 0,
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: AppColors.primary,
                                  width: 0.5
                              ),
                              borderRadius: BorderRadius.circular(8.0)
                          ),
                          child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        child: Image.asset(
                                          contributor['image']!,
                                          width: 80,
                                          height: 80,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      const SizedBox(width: 20),
                                      Expanded(child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            contributor['name']!,
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            contributor['designation']!,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontStyle: FontStyle.italic,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            contributor['contribution']!,
                                            style: const TextStyle(fontSize: 14),
                                          ),
                                        ],
                                      ))
                                    ],
                                  )
                                ],
                              )
                          ),
                        ),
                      );
                    },
                  ),
                )
            )
          ],
        ),
      ),
    );
  }
}