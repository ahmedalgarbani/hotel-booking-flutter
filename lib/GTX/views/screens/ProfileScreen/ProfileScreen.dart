import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotels/GTX/Models/rigetermodel.dart';
import 'package:hotels/GTX/controller/connection_controller.dart';
import 'package:hotels/GTX/controller/showProfileinfo.dart';
import 'package:hotels/GTX/controller/updateprofilecontroller.dart';
import 'package:hotels/GTX/views/screens/ChangePasswordPage/ChangePasswordPage.dart';
import 'package:hotels/GTX/views/widgets/ConnectionCheckWidget/ConnectionCheckWidget.dart';
import 'package:hotels/GTX/views/widgets/updateprofile/updateProfile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final Updateprofilecontroller fetcprofil =
      Get.find<Updateprofilecontroller>();
  final NetworkController connectivityController =
      Get.find<NetworkController>();

  @override
  Widget build(BuildContext context) {
   
    
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: GetX<Showprofileinfo>(
          init: Showprofileinfo(),
          builder: (controller) {
            if (controller.profileuserlist.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            final profile = controller.profileuserlist.first;

            return Stack(
              children: [
                CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      expandedHeight: 250,
                      floating: false,
                      pinned: true,
                      flexibleSpace: FlexibleSpaceBar(
                        background: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.network(
                              profile.image!,
                              fit: BoxFit.cover,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.transparent,
                                    Colors.black.withOpacity(0.7),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      leading: IconButton(
                        icon: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.9),
                            shape: BoxShape.circle,
                          ),
                          child:
                              const Icon(Icons.arrow_back, color: Colors.black),
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                      actions: [
                        IconButton(
                          icon: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.9),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.edit, color: Colors.black),
                          ),
                          onPressed: () {
                            if (controller.profileuserlist.isNotEmpty) {
                              final user = controller.profileuserlist[0];
                              fetcprofil.fetchupdate(user: user);
                              // Get.put(Updateprofilecontroller(user));
                              Get.to(() => EditProfileScreen());

                              print("تم الإرسال");
                            } else {
                              print("القائمة فارغة");
                            }
                          },
                        ),
                        const SizedBox(width: 8),
                      ],
                    ),
                    SliverToBoxAdapter(
                      child: Transform.translate(
                        offset: const Offset(0, -60),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.secondary,
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(30),
                            ),
                          ),
                          child: Column(
                            children: [
                              const SizedBox(height: 20),
                              _buildProfileInfo(profile),
                              const Divider(height: 20),
                              const SizedBox(height: 20),
                              _buildSettingsList(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: 200,
                  left: 20,
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.all(5),
                        child: Text(
                          '${profile.firstName} ${profile.lastName}',
                          style: TextStyle(
                            fontSize: 28,
                            color: Colors.grey[500],
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 4),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 10,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(
                            profile.image ?? 'https://via.placeholder.com/150',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      );
   
  }

  Widget _buildProfileInfo(Rigetermodel profile) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 30),
          Container(
            margin: EdgeInsets.only(top: 13),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 2,
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                _buildInfoItem(
                  icon: Icons.phone,
                  title: "Phone",
                  value: '${profile.phone}',
                ),
                const Divider(height: 20),
                _buildInfoItem(
                  icon: Icons.person_outline,
                  title: "Username",
                  value: '${profile.username}',
                ),
                const Divider(height: 20),
                _buildInfoItem(
                  icon: Icons.calendar_today,
                  title: "Email",
                  value: '${profile.email}',
                ),
                const Divider(height: 20),
                _buildInfoItem(
                  icon: Icons.calendar_today,
                  title: "Birth Date",
                  value: '${profile.birth_date}',
                ),
                const Divider(height: 20),
                _buildInfoItem(
                  icon: Icons.person,
                  title: "Gender",
                  value: '${profile.gender}',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: Colors.blue, size: 22),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsList() {
    return Container(
      margin: EdgeInsets.only(left: 11, right: 15),
      child: Column(
        children: [
          TextButton(
            onPressed: () {
              Get.to(() => ChangePasswordPage());
            },
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon((Icons.lock), color: Colors.blue, size: 22),
                ),
                SizedBox(width: 8),
                Text(
                  "Change Password",
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _linedivi() {
    return Divider(
      color: Colors.blue,
      thickness: 1, // سمك الخط
      height: 20, // المسافة الرأسية حول الخط
      indent: 16, // مسافة البداية من اليسار
      endIndent: 16, // مسافة النهاية من اليمين
    );
  }
}
