module ObjectCreationMethods
  def team_params(overrides = {})
    defaults = {
      name: "The #{color} #{animal}"
    }
    defaults.merge(overrides)
  end

  def new_team(overrides = {})
    Team.new(team_params(overrides))
  end

  def create_team(overrides = {})
    new_team(overrides).tap(&:save!)
  end

  def match_result_params(overrides = {})
    defaults = {
      home_team_id: create_team.id,
      home_goals: 2,
      home_red_cards: 1,
      away_team_id: create_team.id,
      away_goals: 2,
      away_red_cards: 1,
    }
    defaults.merge(overrides)
  end

  def new_match_result(overrides = {})
    MatchResult.new(match_result_params(overrides))
  end

  def create_match_result(overrides = {})
    new_match_result(overrides).tap(&:save!)
  end

  private

  def color
    %w[amaranth amber amethyst apricot aqua aquamarine azure beige black blue blush bronze brown chocolate coffee copper coral crimson cyan emerald fuchsia gold gray green harlequin indigo ivory jade lavender lime magenta maroon moccasin olive orange peach pink plum purple red rose salmon sapphire scarlet silver tan teal tomato turquoise violet white yellow].sample
  end

  def animal
    %w[aardvark aardwolf albatross alligator alpaca amphibian anaconda angelfish anglerfish ant anteater antelope antlion ape aphid armadillo asp baboon badger bandicoot barnacle barracuda basilisk bass bat bear beaver bedbug bee beetle bird bison blackbird boa boar bobcat bobolink bonobo booby bovid bug butterfly buzzard camel canid canidae capybara cardinal caribou carp cat caterpillar catfish catshark cattle centipede cephalopod chameleon cheetah chickadee chicken chimpanzee chinchilla chipmunk cicada clam clownfish cobra cockroach cod condor constrictor coral cougar cow coyote crab crane crawdad crayfish cricket crocodile crow cuckoo damselfly deer dingo dinosaur dog dolphin donkey dormouse dove dragon dragonfly duck eagle earthworm earwig echidna eel egret elephant elk emu ermine falcon felidae ferret finch firefly fish flamingo flea fly flyingfish fowl fox frog galliform gamefowl gayal gazelle gecko gerbil gibbon giraffe goat goldfish goose gopher gorilla grasshopper grouse guan guanaco guineafowl gull guppy haddock halibut hamster hare harrier hawk hedgehog heron herring hippopotamus hookworm hornet horse hoverfly hummingbird hyena iguana impala jackal jaguar jay jellyfish junglefowl kangaroo kingfisher kite kiwi koala koi krill ladybug lamprey landfowl lark leech lemming lemur leopard leopon limpet lion lizard llama lobster locust loon louse lungfish lynx macaw mackerel magpie mammal manatee mandrill marlin marmoset marmot marsupial marten mastodon meadowlark meerkat mink minnow mite mockingbird mole mollusk mongoose monkey moose mosquito moth mouse mule muskox narwhal newt nightingale ocelot octopus opossum orangutan orca ostrich otter owl ox panda panther parakeet parrot parrotfish partridge peacock peafowl pelican penguin perch pheasant pig pigeon pike pinniped piranha planarian platypus pony porcupine porpoise possum prawn primate ptarmigan puffin puma python quail quelea quokka rabbit raccoon rat rattlesnake raven reindeer reptile rhinoceros roadrunner rodent rook rooster roundworm sailfish salamander salmon sawfish scallop scorpion seahorse shark sheep shrew shrimp silkworm silverfish skink skunk sloth slug smelt snail snake snipe sole sparrow spider spoonbill squid squirrel starfish stingray stoat stork sturgeon swallow swan swift swordfish swordtail tahr takin tapir tarantula tarsier termite tern thrush tick tiger tiglon toad tortoise toucan trout tuna turkey turtle tyrannosaurus unicorn urial vicuna viper vole vulture wallaby walrus warbler wasp weasel whale whippet whitefish wildcat wildebeest wildfowl wolf wolverine wombat woodpecker worm wren xerinae yak zebra].sample
  end
end