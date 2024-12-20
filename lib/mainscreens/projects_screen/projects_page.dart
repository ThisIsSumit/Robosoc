// ignore_for_file: library_private_types_in_public_api, use_super_parameters

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:robosoc/mainscreens/homescreen/profile_screen.dart';
import 'package:robosoc/models/project_model.dart';
import 'package:robosoc/utilities/project_provider.dart';
import 'package:robosoc/mainscreens/projects_screen/detailed_project_viewscreen.dart';
import 'package:robosoc/widgets/project_list_item.dart';
import 'package:robosoc/widgets/user_image.dart';

class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({Key? key}) : super(key: key);

  @override
  _ProjectsScreenState createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<ProjectProvider>(context, listen: false).fetchProjects());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,s
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Hi!",
                          style: TextStyle(
                              fontSize: 16, fontFamily: "NexaRegular")),
                      Text(
                        "Welcome",
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            fontFamily: "NexaBold"),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ProfileScreen())),
                    child: const UserImage(
                      imagePath: "assets/images/defaultPerson.png",
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search Project',
                  hintStyle: TextStyle(fontFamily: "NexaRegular"),
                  prefixIcon: const Icon(Icons.search),
                  fillColor: Colors.grey.shade100,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Ongoing Projects',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: "NexaBold",
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: Consumer<ProjectProvider>(
                  builder: (context, projectProvider, child) {
                    if (projectProvider.isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    final ongoingProjects = projectProvider.projects
                        .where((p) => p.status == 'ongoing')
                        .toList();

                    return ListView.builder(
                      itemCount: ongoingProjects.length,
                      itemBuilder: (context, index) {
                        return ProjectListItem(
                          project: ongoingProjects[index],
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailedProjectScreen(
                                  project: ongoingProjects[index],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Completed Projects',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: "NexaBold",
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: Consumer<ProjectProvider>(
                  builder: (context, projectProvider, child) {
                    final completedProjects = projectProvider.projects
                        .where((p) => p.status == 'completed')
                        .toList();

                    return ListView.builder(
                      itemCount: completedProjects.length,
                      itemBuilder: (context, index) {
                        return ProjectListItem(
                          project: completedProjects[index],
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailedProjectScreen(
                                  project: completedProjects[index],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
