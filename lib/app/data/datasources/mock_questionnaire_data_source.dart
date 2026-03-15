import '../../domain/models/question.dart';
import '../../domain/models/questionnaire.dart';

class MockQuestionnaireDataSource {
  const MockQuestionnaireDataSource();

  Future<List<Questionnaire>> fetchQuestionnaires() async {
    // Local mock data for now. Easy to replace with an API later.
    await Future<void>.delayed(const Duration(milliseconds: 200));
    return _questionnaires;
  }
}

const _questionnaires = <Questionnaire>[
  Questionnaire(
    id: 'daily-routine',
    title: 'Daily Routine Survey',
    description: 'Understand habits, productivity, and wellness patterns.',
    questions: [
      Question(
        id: 'wake-up-time',
        text: 'What time do you usually wake up?',
        options: ['Before 6 AM', '6 AM - 7 AM', '7 AM - 8 AM', 'After 8 AM'],
      ),
      Question(
        id: 'breakfast',
        text: 'How often do you eat breakfast?',
        options: ['Daily', '3-5 times a week', '1-2 times a week', 'Rarely'],
      ),
      Question(
        id: 'exercise',
        text: 'How often do you exercise in a week?',
        options: ['Daily', '3-4 times', '1-2 times', 'Never'],
      ),
      Question(
        id: 'work-mode',
        text: 'Which work mode keeps you most productive?',
        options: [
          'Deep focus',
          'Team collaboration',
          'Flexible mix',
          'No preference',
        ],
      ),
      Question(
        id: 'sleep-hours',
        text: 'How many hours do you sleep on average?',
        options: ['Less than 5', '5-6', '7-8', 'More than 8'],
      ),
    ],
  ),
  Questionnaire(
    id: 'shopping-preferences',
    title: 'Shopping Preferences',
    description: 'Capture buying behavior and digital shopping comfort.',
    questions: [
      Question(
        id: 'frequency',
        text: 'How often do you shop online?',
        options: ['Weekly', 'Monthly', 'Few times a year', 'Never'],
      ),
      Question(
        id: 'device',
        text: 'Which device do you prefer for shopping?',
        options: ['Phone', 'Tablet', 'Laptop', 'Desktop'],
      ),
      Question(
        id: 'payment',
        text: 'Which payment method do you trust the most?',
        options: ['UPI', 'Card', 'Net banking', 'Cash on delivery'],
      ),
      Question(
        id: 'deal-factor',
        text: 'What influences your purchase most?',
        options: ['Discounts', 'Reviews', 'Brand', 'Fast delivery'],
      ),
      Question(
        id: 'return-policy',
        text: 'How important is an easy return policy?',
        options: ['Critical', 'Important', 'Nice to have', 'Not important'],
      ),
    ],
  ),
  Questionnaire(
    id: 'travel-style',
    title: 'Travel Style Finder',
    description: 'Map comfort, planning style, and travel priorities.',
    questions: [
      Question(
        id: 'trip-frequency',
        text: 'How often do you take personal trips?',
        options: ['Every month', 'Every quarter', 'Twice a year', 'Rarely'],
      ),
      Question(
        id: 'planning',
        text: 'How do you usually plan travel?',
        options: [
          'Weeks ahead',
          'A few days ahead',
          'Spontaneously',
          'Group decides',
        ],
      ),
      Question(
        id: 'stay-type',
        text: 'What accommodation do you prefer?',
        options: ['Hotel', 'Resort', 'Hostel', 'Homestay'],
      ),
      Question(
        id: 'budget-priority',
        text: 'What matters most when choosing a trip?',
        options: ['Budget', 'Comfort', 'Adventure', 'Local culture'],
      ),
      Question(
        id: 'travel-company',
        text: 'Who do you usually travel with?',
        options: ['Solo', 'Family', 'Friends', 'Colleagues'],
      ),
    ],
  ),
];
