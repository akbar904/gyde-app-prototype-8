
// home_viewmodel.dart
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
	final NavigationService _navigationService;
	String? featuredChauffeurName;
	String? featuredChauffeurRating;
	bool isLoading = false;

	HomeViewModel(this._navigationService);

	void initialize() {
		loadChauffeurDetails();
	}

	void loadChauffeurDetails() {
		isLoading = true;
		notifyListeners();
		
		// Simulated API call
		Future.delayed(const Duration(seconds: 1), () {
			featuredChauffeurName = "James Wilson";
			featuredChauffeurRating = "4.9";
			isLoading = false;
			notifyListeners();
		});
	}

	void navigateToOneWayBooking() {
		_navigationService.navigateTo('/one-way-booking');
	}

	void navigateToMultiStopBooking() {
		_navigationService.navigateTo('/multi-stop-booking');
	}

	void navigateToHourlyBooking() {
		_navigationService.navigateTo('/hourly-booking');
	}
}

// home_view.dart
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:gap/gap.dart';
import './home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
	const HomeView({Key? key}) : super(key: key);

	@override
	Widget builder(BuildContext context, HomeViewModel viewModel, Widget? child) {
		return Scaffold(
			backgroundColor: Colors.black,
			body: SafeArea(
				child: Padding(
					padding: const EdgeInsets.all(16.0),
					child: Column(
						crossAxisAlignment: CrossAxisAlignment.start,
						children: [
							const Text(
								'Welcome to Gyde',
								style: TextStyle(
									color: Colors.white,
									fontSize: 28,
									fontWeight: FontWeight.bold,
								),
							),
							const Gap(24),
							_buildServiceCategories(viewModel),
							const Gap(32),
							_buildFeaturedChauffeur(viewModel),
						],
					),
				),
			),
		);
	}

	Widget _buildServiceCategories(HomeViewModel viewModel) {
		return Column(
			crossAxisAlignment: CrossAxisAlignment.start,
			children: [
				const Text(
					'Service Categories',
					style: TextStyle(
						color: Colors.white,
						fontSize: 20,
						fontWeight: FontWeight.w600,
					),
				),
				const Gap(16),
				Row(
					mainAxisAlignment: MainAxisAlignment.spaceBetween,
					children: [
						_buildServiceCard(
							'One Way',
							Icons.arrow_forward,
							viewModel.navigateToOneWayBooking,
						),
						_buildServiceCard(
							'Multi Stop',
							Icons.more_horiz,
							viewModel.navigateToMultiStopBooking,
						),
						_buildServiceCard(
							'Hourly',
							Icons.access_time,
							viewModel.navigateToHourlyBooking,
						),
					],
				),
			],
		);
	}

	Widget _buildServiceCard(String title, IconData icon, VoidCallback onTap) {
		return InkWell(
			onTap: onTap,
			child: Container(
				padding: const EdgeInsets.all(16),
				decoration: BoxDecoration(
					color: Colors.grey[900],
					borderRadius: BorderRadius.circular(12),
				),
				child: Column(
					children: [
						Icon(icon, color: Colors.white, size: 32),
						const Gap(8),
						Text(
							title,
							style: const TextStyle(color: Colors.white),
						),
					],
				),
			),
		);
	}

	Widget _buildFeaturedChauffeur(HomeViewModel viewModel) {
		return Container(
			padding: const EdgeInsets.all(16),
			decoration: BoxDecoration(
				color: Colors.grey[900],
				borderRadius: BorderRadius.circular(12),
			),
			child: viewModel.isLoading
				? const Center(child: CircularProgressIndicator())
				: Column(
					crossAxisAlignment: CrossAxisAlignment.start,
					children: [
						const Text(
							'Featured Chauffeur',
							style: TextStyle(
								color: Colors.white,
								fontSize: 18,
								fontWeight: FontWeight.w600,
							),
						),
						const Gap(16),
						Row(
							children: [
								CircleAvatar(
									radius: 30,
									backgroundColor: Colors.grey[800],
									child: const Icon(Icons.person, color: Colors.white),
								),
								const Gap(16),
								Column(
									crossAxisAlignment: CrossAxisAlignment.start,
									children: [
										Text(
											viewModel.featuredChauffeurName ?? '',
											style: const TextStyle(
												color: Colors.white,
												fontSize: 16,
											),
										),
										Row(
											children: [
												const Icon(Icons.star, color: Colors.amber, size: 16),
												const Gap(4),
												Text(
													viewModel.featuredChauffeurRating ?? '',
													style: const TextStyle(color: Colors.white),
												),
											],
										),
									],
								),
							],
						),
					],
				),
		);
	}

	@override
	HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel(
		NavigationService(),
	);

	@override
	void onViewModelReady(HomeViewModel viewModel) => viewModel.initialize();
}
