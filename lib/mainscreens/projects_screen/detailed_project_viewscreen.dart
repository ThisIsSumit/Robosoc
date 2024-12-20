import 'package:flutter/material.dart';
import 'package:robosoc/models/project_model.dart';
import 'package:robosoc/mainscreens/project_updates/add_update_screen.dart';
import 'package:robosoc/mainscreens/project_updates/view_update_screen.dart';
import 'package:robosoc/widgets/project_update_card.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailedProjectScreen extends StatelessWidget {
  final Project project;

  const DetailedProjectScreen({
    Key? key,
    required this.project,
  }) : super(key: key);

  Future<void> _launchProjectLink() async {
    final Uri url = Uri.parse(project.link);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 32.0),
          child: Text(
            project.title.toUpperCase(),
            style: TextStyle(
                color: Colors.amber,
                fontFamily: "NexaBold",
                fontWeight: FontWeight.w900),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddUpdateScreen(project: project),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image with error handling
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.amber, width: 4),
                  borderRadius: BorderRadius.circular(19)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: AspectRatio(
                  aspectRatio: 1 / 1.25,
                  child: Image.network(
                    project.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[300],
                        child: const Center(
                          child: Icon(Icons.image_not_supported),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    project.title.toUpperCase(),
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold, fontFamily: "NexaBold"),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    project.description,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontFamily: "NexaRegular"),
                  ),
                  const SizedBox(height: 16),
                  if (project.link.isNotEmpty)
                    ElevatedButton.icon(
                      onPressed: _launchProjectLink,
                      icon: const Icon(
                        Icons.link,
                        color: Colors.amber,
                      ),
                      label: const Text(
                        'View Project',
                        style: TextStyle(
                            color: Colors.amber, fontFamily: "NexaBold"),
                      ),
                    ),
                  const SizedBox(height: 24),
                  Text(
                    'UPDATES',
                    style: TextStyle(
                      fontFamily: "NexaBold",
                      fontSize: 26,
                    ),
                  ),
                  const SizedBox(height: 8),
                  project.updates.isEmpty
                      ? const Center(
                          child: Text(
                          'No updates yet',
                          style: TextStyle(fontFamily: "NexaRegular"),
                        ))
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: project.updates.length,
                          itemBuilder: (context, index) {
                            final update = project.updates[index];
                            return ProjectUpdateCard(
                              update: update,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ViewUpdateScreen(
                                      update: update,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
