require 'rubygems'
require 'telegram/bot'

require 'json'

token = '151859131:AAE704OpG3wnjVPvoQu54dpKHZmVTd5Zmp0'

#some commands:
##{message.from.first_name} => name of person sayin

$Shut_Up = false
users_array = Array.new 

#initialize

if File.exists?('users.json') 
  json = File.read('users.json')
  users_array = JSON.parse(json)
  puts 'New users.json is made'
else
  users_array = Array.new 
  puts 'Existing users.json file is read'
end 


def evaluate_mute(bot,message,text)
  if text == '/diam' 
    bot.api.send_message(chat_id: message.chat.id, text: "T_T ok lah")
    $Shut_Up = true
  elsif text == '/kong'
    bot.api.send_message(chat_id: message.chat.id, text:"Yay")
    $Shut_Up = false
  end
end

def evaluate_message(bot, message, users_array)
  case message.text
  when /^jiao.*/
    bot.api.send_message(chat_id: message.chat.id, text: "#{users_array.sample} someone wanna jiao you")
  when '/users'
    bot.api.send_message(chat_id: message.chat.id, text: "Users I know in here are: #{users_array}")
  when 'stim bot'
    bot.api.send_message(chat_id: message.chat.id, text: "Sorry lorr")
  when /.*good nights.*/
    bot.api.send_message(chat_id: message.chat.id, text: "Good nights #{message.from.first_name}.")
  end
end


Telegram::Bot::Client.run(token, logger: Logger.new($stdout)) do |bot|
  bot.logger.info('Bot has been started')
  bot.listen do |message|

    evaluate_mute(bot, message, message.text)

    if users_array.include?(message.from.first_name)
      #do nothing as he's here
    else
      users_array << message.from.first_name
      File.open("users.json","w") do |f|
        f.puts JSON.pretty_generate(users_array)
      end
      bot.api.send_message(chat_id: message.chat.id, text:"Hey #{message.from.first_name}")
    end

    unless $Shut_Up
      evaluate_message(bot, message, users_array)
    end

  end
end

