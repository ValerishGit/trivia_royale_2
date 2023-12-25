import 'dart:math';

class HelperFunctions {
  static String generateRandomName() {
    List<String> adjectives = [
      'Smart',
      'Clever',
      'Quick',
      'Witty',
      'Sharp',
      'Bright',
      'Intelligent',
      'Astute',
      'Savvy',
      'Inventive',
      'Resourceful',
      'Insightful',
      'Knowledgeable',
      'Adaptable',
      'Versatile',
      'Creative',
      'Logical',
      'Analytical',
      'Brilliant',
      'Perceptive',
      'Talented',
      'Eloquent',
      'Inquisitive',
      'Energetic',
      'Diligent',
      'Persistent',
      'Dynamic',
      'Efficient',
      'Innovative',
      'Adventurous',
      'Courageous',
      'Ambitious',
      'Passionate',
      'Resilient',
      'Tenacious',
      'Patient',
      'Punctual',
      'Honest',
      'Ethical',
      'Charismatic',
      'Inspiring',
      'Empathetic',
      'Determined',
      'Committed',
      'Sincere',
      'Graceful',
      'Humble',
      'Courteous',
      'Radiant'
    ];

    List<String> nouns = [
      'Quizzer',
      'Mastermind',
      'Brainiac',
      'Genius',
      'Whiz',
      'Savant',
      'Prodigy',
      'Scholar',
      'Expert',
      'Maestro',
      'Pundit',
      'Oracle',
      'Enigma',
      'Guru',
      'Connoisseur',
      'Maven',
      'Aficionado',
      'Virtuoso',
      'Specialist',
      'Juggernaut',
      'Pioneer',
      'Trailblazer',
      'Champion',
      'Crusader',
      'Visionary',
      'Trailblazer',
      'Navigator',
      'Architect',
      'Mentor',
      'Guide',
      'Sage',
      'Patriot',
      'Alchemist',
      'Dreamer',
      'Voyager',
      'Warrior',
      'Maestro',
      'Navigator',
      'Pioneer',
      'Virtuoso',
      'Conqueror',
      'Rogue',
      'Sorcerer',
      'Dreamweaver',
      'Sculptor',
      'Nomad',
      'Jester',
      'Magician'
    ];

    List<int> numbers = List.generate(150, (index) => index + 1);

    Random random = Random();

    String adjective = adjectives[random.nextInt(adjectives.length)];
    String noun = nouns[random.nextInt(nouns.length)];
    String number = numbers[random.nextInt(numbers.length)].toString();

    return '$adjective $noun $number';
  }
}
