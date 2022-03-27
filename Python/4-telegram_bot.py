import telebot

bot = telebot.TeleBot(
    "5162132635:AAEeP6maFXGhqk38c1dBzwHTvAah6L6_3LM", parse_mode=None)


@bot.message_handler(commands=['start', 'help'])
def send_welcome(message):
	bot.reply_to(message, "Howdy, how are you doing?")


bot.infinity_polling()
