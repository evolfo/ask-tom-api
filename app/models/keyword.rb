require 'net/http'
require 'open-uri'
require 'json'

class Keyword < ApplicationRecord
	validates :subject, format: { with: /[a-zA-Z\s]+/, message: "can only contain letters." }

	validates :keyword_type, format: { with: /[a-zA-Z\s]+/, message: "can only contain letters." }

	validates :purpose, format: { with: /[a-zA-Z\s]+/, message: "can only contain letters." }

	validate :block_obscenity
	validate :string_length
	validate :make_sure_one_word
	validate :subject_is_in_dictionary
	validate :keyword_is_in_dictionary
	validate :purpose_is_in_dictionary

	def subject_is_in_dictionary
		puts subject.last
		url = "https://www.dictionaryapi.com/api/v3/references/collegiate/json/#{subject.last}?key=#{Rails.application.credentials.miriam_webster[:api_key]}"

		uri = URI.parse(url)
		response = Net::HTTP.get_response(uri)
		dictionary_hash = JSON.parse(response.body)

		if dictionary_hash[0].class != Hash
			errors.add(:subject, "must be a real word")
		end
	end

	def keyword_is_in_dictionary
		url = "https://www.dictionaryapi.com/api/v3/references/collegiate/json/#{keyword_type.last}?key=#{Rails.application.credentials.miriam_webster[:api_key]}"

		uri = URI.parse(url)
		response = Net::HTTP.get_response(uri)
		dictionary_hash = JSON.parse(response.body)

		if dictionary_hash[0].class != Hash
			errors.add(:keyword, "must be a real word")
		end
	end

	def purpose_is_in_dictionary
		url = "https://www.dictionaryapi.com/api/v3/references/collegiate/json/#{purpose.last}?key=#{Rails.application.credentials.miriam_webster[:api_key]}"

		uri = URI.parse(url)
		response = Net::HTTP.get_response(uri)
		dictionary_hash = JSON.parse(response.body)

		if dictionary_hash[0].class != Hash
			errors.add(:purpose, "must be a real word")
		end
	end


	def make_sure_one_word
		if subject.last.split.length > 1
			errors.add(:subject, "TOO LONG SLOW DOWN")
		end
		if purpose.last.split.length > 1
			errors.add(:purpose, "TOO LONG SLOW DOWN")
		end
		if keyword_type.last.split.length > 1
			errors.add(:keyword_type, "TOO LONG SLOW DOWN")
		end
	end

	def string_length
		if subject.last.length > 15 || keyword_type.last.length > 15 || purpose.last.length > 15
			errors.add(:subject, "STOP PLZ")
		end
	end

	def block_obscenity
		if swear_words.include?(subject.last)
			errors.add(:subject, "U A WAP")
		end
		if swear_words.include?(keyword_type.last)
			errors.add(:keyword_type, "U A WAP")
		end
		if swear_words.include?(purpose.last)
			errors.add(:purpose, "U A WAP")
		end
	end

	private 

	def swear_words
	  @swear_words = [
		 'aclit',
		 'adick',
		 'aids',
		 'alabama porch monkey',
		 'anal intruder',
		 'anal invader',
		 'analicker',
		 'anus',
		 '"4r5e"',
		 '"5h1t"',
		 '"5hit"',
		 'a55',
		 'anal',
		 'ar5e',
		 'arrse',
		 'arse',
		 'ass',
		 'as$',
		 'ass bandit',
		 'ass clown',
		 'ass face',
		 'ass fucker',
		 'ass hole',
		 'ass load',
		 'ass much',
		 'ass out',
		 'ass packer',
		 'ass reamer',
		 'ass whacker',
		 'ass wipe',
		 'assbandit',
		 'assclown',
		 'asscrack',
		 'assed out',
		 'assface',
		 'assfucker',
		 'asshole',
		 'asslicker',
		 'assload',
		 'assmunch',
		 'assout',
		 'asspacker',
		 'assreamer',
		 'asswhacker',
		 'asswipe',
		 'baby batter',
		 'babybatter',
		 'ball breaker',
		 'ball buster',
		 'baller',
		 'balling',
		 'bat shit',
		 'batshit',
		 'bearded clam',
		 'bearded taco',
		 'beardedclam',
		 'beardedtaco',
		 'beaver',
		 'beavershot',
		 'beeatch',
		 'beener',
		 'biatch',
		 'big baller',
		 'bigballer',
		 'bimbo',
		 'bitch',
		 'bite me',
		 'biteme',
		 'blewinski',
		 'blood fart',
		 'bloodfart',
		 'blow job',
		 'blow me',
		 'blow my pole',
		 'blowjob',
		 'blowme',
		 'blue ball',
		 'blue balls',
		 'blueball',
		 'blueballs',
		 'boner',
		 'bull dike',
		 'bull shit',
		 'bulldike',
		 'bullshit',
		 'bung hole',
		 'bunghole',
		 'butt bandit',
		 'butt banger',
		 'butt buddy',
		 'butt crust',
		 'butt nugger',
		 'butt pirate',
		 'butt plug',
		 'buttbandit',
		 'buttbanger',
		 'buttcrack',
		 'buttfuck',
		 'buttfucker',
		 'butthump',
		 'buttnugger',
		 'buttpirate',
		 'buttplug',
		 'buttporn',
		 'c0ck',
		 'camel jockey',
		 'camel toe',
		 'cameltoe',
		 'carpet eater',
		 'carpeteater',
		 'cherry popper',
		 'cherrypopper',
		 'chinc',
		 'chink',
		 'choad',
		 'chode',
		 'choke my chicken',
		 'choking the chicken',
		 'cocaine',
		 'cock jockey',
		 'cock knocker',
		 'cock lord',
		 'cock ring',
		 'cock smoker',
		 'cock sucker',
		 'cock tease',
		 'cockass',
		 'cockblocker',
		 'cockjockey',
		 'cocklord',
		 'cocknocker',
		 'cockring',
		 'cocksmoker',
		 'cocksucker',
		 'cocktease',
		 'condom',
		 'coochie',
		 'coon',
		 'cootch',
		 'cooze',
		 'corn hole',
		 'cornhole',
		 'crack ho',
		 'crack spackler',
		 'crackbitch',
		 'cracker',
		 'crackspacker',
		 'crackspackler',
		 'crakker',
		 'crap',
		 'crap face',
		 'crap head',
		 'crapface',
		 'craphead',
		 'crapper',
		 'cum',
		 'cum belch',
		 'cum belcher',
		 'cum bubble',
		 'cum dumpster',
		 'cum guzzle',
		 'cum guzzler',
		 'cum lapper',
		 'cum licker',
		 'cum stain',
		 'cum sucker',
		 'cumbelch',
		 'cumbelcher',
		 'cumbeltch',
		 'cumbeltcher',
		 'cumbubble',
		 'cumdumpster',
		 'cumguzzle',
		 'cumguzzler',
		 'cumlapper',
		 'cumlicker',
		 'cumm',
		 'cumm bubble',
		 'cumm dumpster',
		 'cumm guzzler',
		 'cumm stain',
		 'cumm sucker',
		 'cummbubble',
		 'cummdumpster',
		 'cummguzzler',
		 'cummstain',
		 'cummsucker',
		 'cumstain',
		 'cumsucker',
		 'cumsuker',
		 'cumwad',
		 'cunt',
		 'cunt hair',
		 'cunt whisker',
		 'cunthair',
		 'cuntwhisker',
		 'cuntwisker',
		 'cuze',
		 'd i c k',
		 'daisy chain',
		 'daisy gang',
		 'dangelberry',
		 'dangleberry',
		 'deez nuts',
		 'devil',
		 'dick breath',
		 'dick fiend',
		 'dick head',
		 'dick nose',
		 'dick wad',
		 'dick weed',
		 'dickbreath',
		 'dickface',
		 'dickfiend',
		 'dickhead',
		 'dicknose',
		 'dickwad',
		 'dickweed',
		 'dik breath',
		 'dik fiend',
		 'dik head',
		 'dikbreath',
		 'dike',
		 'dikfiend',
		 'dikhead',
		 'dildo',
		 'dingelberry',
		 'dingleberry',
		 'dipstick',
		 'douche',
		 'douche bag',
		 'drain the lizard',
		 'drugs',
		 'dune coon',
		 'dunecoon',
		 'earning red wings',
		 'eat me',
		 'eat my shorts',
		 'eatme',
		 'ecstacy',
		 'eggplant',
		 'ejaculate',
		 'fagg',
		 'faggot',
		 'faghump',
		 'fagmunch',
		 'felch',
		 'felcher',
		 'feltch',
		 'feltcher',
		 'finger bang',
		 'finger banged',
		 'finger banger',
		 'finger fuck',
		 'fingerbang',
		 'fingerbanged',
		 'fingerbanger',
		 'fingerfuck',
		 'flamer',
		 'flip',
		 'flogging the bishop',
		 'fore skin',
		 'foreskin',
		 'fuck',
		 'fuck face',
		 'fucked',
		 'fucker',
		 'fuckers',
		 'fuckface',
		 'fucking',
		 'fucknut',
		 'fucknuts',
		 'fucks',
		 'fuckshit',
		 'fuckstick',
		 'fudge packer',
		 'fudgepacker',
		 'fuk',
		 'fuk you',
		 'fuker',
		 'fukkhead',
		 'fur burger',
		 'furbuger',
		 'furry burger',
		 'fury burger',
		 'fvck',
		 'fvck you',
		 'fvcker',
		 'fvckface',
		 'fvcking',
		 'fvcknut',
		 'fvcknuts',
		 'gang bang',
		 'gangbang',
		 'genocide',
		 'gniga',
		 'gook',
		 'hairy hatchet wound',
		 'hairy taco',
		 'hairyhatchetwound',
		 'hairytaco',
		 'half breed',
		 'halfbreed',
		 'hardon',
		 'hell',
		 'hermaphrodite',
		 'herpes',
		 'ho',
		 'hoes',
		 'hommo',
		 'homo',
		 'honkey',
		 'honky',
		 'hoochie mama',
		 'hooker',
		 'horse shit',
		 'horseshit',
		 'hot beef injection',
		 'incest',
		 'jacking off',
		 'jap',
		 'jerking off',
		 'jiz',
		 'jiz muffin',
		 'jiz sandwich',
		 'jizer',
		 'jizm',
		 'jizmuffin',
		 'jizz',
		 'jizz muffin',
		 'jizz sandwich',
		 'jizzer',
		 'jizzm',
		 'jizzmuffin',
		 'jungle bunny',
		 'junglebunny',
		 'kike',
		 'kill',
		 'koochie',
		 'koochy',
		 'kootch',
		 'kootchie',
		 'kootchy',
		 'kum',
		 'kumm',
		 'lesbo',
		 'lettuce picker',
		 'lettucepicker',
		 'lezbo',
		 'lick my nuts',
		 'lickcock',
		 'licknipple',
		 'limpdick',
		 'love canal',
		 'lsd',
		 'man whore',
		 'mangina',
		 'manwhore',
		 'marijuana',
		 'masturbate',
		 'mick',
		 'monkeydick',
		 'monkeyhumper',
		 'mooli',
		 'mother fucker',
		 'motherfucker',
		 'mud people',
		 'mud person',
		 'mudpeople',
		 'mudperson',
		 'muff',
		 'muff diver',
		 'muffdiver',
		 'muli',
		 'murder',
		 'nazi',
		 'niger',
		 'nigga',
		 'niggah',
		 'nigger',
		 'nip',
		 'nipple',
		 'nutted',
		 'nutter',
		 'nutting',
		 'one way pipe cleaner',
		 'panocha',
		 'pcp',
		 'pecker',
		 'pecker head',
		 'pecker nose',
		 'peckerhead',
		 'peckernose',
		 'pedophile',
		 'penis breath',
		 'penisbreath',
		 'phelch',
		 'phelcher',
		 'pheltch',
		 'pheltcher',
		 'phlip',
		 'pillow biter',
		 'pillowbiter',
		 'pimp',
		 'pinis wrinkle',
		 'piniswrinkle',
		 'pipe hitter',
		 'pipehitter',
		 'piss',
		 'pissdrinker',
		 'pisslicker',
		 'pito',
		 'pole sitter',
		 'pole smoker',
		 'polesitter',
		 'polesmoker',
		 'polish the bishop',
		 'polishing the torpedo',
		 'polock',
		 'poon tang',
		 'poontang',
		 'poop chute',
		 'poop stain',
		 'poopchute',
		 'poopstain',
		 'popped cherry',
		 'poppedcherry',
		 'prick',
		 'psilocybin',
		 'pu55y',
		 'pussie',
		 'pussy',
		 'pussy juice',
		 'pussy juiced',
		 'pussy juicer',
		 'pussy juicing',
		 'pussy pounder',
		 'pussy pounding',
		 'pussy whipped',
		 'pussy whipper',
		 'pussy wiped',
		 'pussyjuice',
		 'pussyjuicer',
		 'pussywhipped',
		 'pussywhipper',
		 'pussywiped',
		 'puta',
		 'pv55ie',
		 'pv55y',
		 'rag head',
		 'raghead',
		 'rectal',
		 'rectum',
		 'redneck',
		 'retard',
		 'retarded',
		 'rim job',
		 'rimjob',
		 'rug munch',
		 'rug munched',
		 'rug muncher',
		 'rugmuncher',
		 'rump ranger',
		 'rumpranger',
		 'rumpshaker',
		 'sachamo',
		 'sambo',
		 'sand niggah',
		 'sand nigger',
		 'sandniggah',
		 'sandnigger',
		 'satanic',
		 'schlong',
		 'scrubbing the carrot',
		 'shit',
		 'shits',
		 'shit eater',
		 'shit face',
		 'shit faced',
		 'shit head',
		 'shit kicker',
		 'shit pusher',
		 'shit shover',
		 'shiteater',
		 'shitface',
		 'shitfaced',
		 'shitfucker',
		 'shithead',
		 'shitkicker',
		 'shitpusher',
		 'shitshover',
		 'skank',
		 'skin flute',
		 'skullfuck',
		 'skullfucked',
		 'skullfucker',
		 'skullfucks',
		 'slap the salami',
		 'slaping the sausage',
		 'slit licker',
		 'slitlicker',
		 'slope',
		 'slut',
		 'slut bag',
		 'slutbag',
		 'smegma',
		 'snog',
		 'sodomise',
		 'sodomised',
		 'sodomiser',
		 'sodomite',
		 'sodomize',
		 'sodomized',
		 'sodomizer',
		 'sodomy',
		 'spank the monkey',
		 'sphincter boy',
		 'sphincter face',
		 'sphincterboy',
		 'sphincterface',
		 'spic',
		 'spick',
		 'spik',
		 'spunk monkey',
		 'suicide',
		 'taint',
		 'tar baby',
		 'tarbaby',
		 'tard',
		 'testes',
		 'testicles',
		 'testicular',
		 'tip polisher',
		 'tit',
		 'tit fuck',
		 'tit fucker',
		 'titfuck',
		 'titfucker',
		 'tits',
		 'titty',
		 'titty twisted',
		 'titty twister',
		 'titty twisters',
		 'titty twisting',
		 'tity',
		 'towel head',
		 'towelhead',
		 'trailer trash',
		 'trailertrash',
		 'transsexual',
		 'transvestite',
		 'twat',
		 'uncle tom',
		 'uplay wid dix',
		 'vag',
		 'vagina licker',
		 'welfare rat',
		 'wet back',
		 'wetback',
		 'whacking off',
		 'white trash',
		 'whore',
		 'wop',
		 'wrapping the weasel',
		 'yclit'
		]
		return @swear_words
	end

end

