# Matchmaker

    1   Matchmaker::Matchmaker.make_me_a_match  
    2   find_me(a_find)  
    3   catch_me(a_catch)  
    4   Matchmaker::Matchmaker.look_through_your_book && 
    5   make_me(a_perfect_match)  

        -inspired by "Matchmaker, Matchmaker" from Fiddler on the Roof, lyrics by Sheldon Harnick

Hi, I'm Matchmaker! 

I exist to help APIs communicate, and to make it easier for you humans 
faciliating their conversations. I believe that by working together through 
open communication, humans and code can uplift each other. You can think of me 
as the Anti-Skynet.

I currently specialize in sending text-based API responses (jokes, chatbots, 
quotes, etc) through a selection of translation and dialect filters (including 
braille), but I would love to do more! There are all sorts of communications I
could learn to interface with, so anytime you want to send information from one
system to another, please think of me! I'm only limited by the dedication of the
people who code me and use me.

Also: I am in no way associated with the musical "Fiddler on the Roof", its 
reference is only intended as affectionate parody. Another name considered
for me was [Shadchan](https://en.wikipedia.org/wiki/Shidduch#Shadchan 
"Wikipedia entry for Shadchan")

Also Also: The above codepoem is not a functional example of my code. 
That would just be silly. I can't see a good reason to expect someone 
to "catch me(a_catch)",  that's exceedingly vague. My goal is to make 
communication easier, not hidden under a candy cloud of falderall and fluff.  
(It is catchy, though).


## Installation

Add this line to your application's Gemfile:


ruby gem 'matchmaker' 


And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install matchmaker

# Usage
[![Matchmaker CLI Walkthrough ](https://img.youtube.com/vi/xKzzpiW77KY/0.jpg)](https://www.youtube.com/watch?v=xKzzpiW77KY)




### Matchmaker::CLI
#### @matchmaker
      Stores the matchmaker object that handles the api interactions.

#### #call
      Initiates the matchmaker and walks the user through their first match
      Then calls the options_menu for further actions
      
#### #cli_options_menu
      Allows the user to select source and filter apis and manipulate the text
      (The meat-and-potatoes of the CLI, currently gives an error when processing certain forms of text)
      
#### #welcome_user
      Displays the user welcome message
      I had a longer introduction here, but it was too wordy and was a distraction. 
      Additional messaging for the CLI can easily be added, or the code refactored to pull from a welcome file

#### #display_text
      Displays matchmaker's current text

#### #select_source
      Displays the currently available source APIS,
      and allows user to select the active API
      
#### #select_filter
      Displays the currently available source APIS,
      and allows user to select the active API
      There's mopre than enough code smell here to suggest it should be merged with select_source
      
#### #get_new_text
      Grabs and displays fresh source text from matchmaker
      
#### #send_current_text
      sends current text to Matchmaker's filter API and displays the response
      
#### #get_integer
      A simple method to as ka user for an integer within range.
      
#### #pause_for_effect
      A simple method for pausing before a screen clear to display relevant data
      

### Matchmaker::Matchmaker

#### @source
      The currently active source API in the format ["NAME", "URL", "CODE"]
      e.g.: ["Official Joke API", 'https://official-joke-api.appspot.com/random_joke', "JOKE"]
      
      
#### @filter
      The currently active filter API in the format  ["NAME", "URL", "CODE"]
      e.g. ["Braille Translator", 'https://fastbraille.com/api/', "BRAILLE"]
      
      
#### @sources
      The default source APIs, curently stored as an array
      Primate candidate for refactoring so it pulls data from a separate file
      Super plus good bonus evolution would allow it to integrate with the larger collection of APIs at 
      repositories like fungenerators.com
      
      
 #### @filters
      Same as sources, above, but with filter apis (APIS that can accept data and offer a response)
      

#### #add_source
      Adds an API to matchmaker's sources array. Must be in the format ["NAME", "URL", "CODE"]
      e.g. Matchmaker::Matchmaker.add_source(["Official Joke API", 'https://official-joke-api.appspot.com/random_joke', "JOKE"])
      

#### #add_filter
      Adds an API to matchmaker's filters array. Must be in the format ["NAME", "URL", "CODE"]
      e.g. Matchmaker::Matchmaker.add_filter(["Braille Translator", 'https://fastbraille.com/api/', "BRAILLE"])
      

#### #fetch_me_a_text
      grabs new text from the source API
      e.g. Matchmaker::Matchmaker.fetch_me_a_text
      
#### #make_me_a_match
      Sends current text to the filter API and updates the current text with the response

#### #update_text
      Updates the current text and saves to text_history


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/silasfelinus/matchmaker. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/silasfelinus/matchmaker/blob/master/CODE_OF_CONDUCT.md).

## License
Matchmaker is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in Matchmaker's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/silasfelinus/matchmaker/blob/master/CODE_OF_CONDUCT.md).


## Ideas for expansion/integration:

Alexa Skill Kit  
Chatbot to Chatbot conversations (Why: For SCIENCE!)  
Sending SMS/Email messages  
Facebook Messenger  
Twilio/Whatsapp  
Profanity Filter  
AI Training  
More languages
Multi-stage filtering  
Logic-driven filtering  



