import Sword
import Foundation

let bot = Sword(token: "MzQwOTAyMjY1OTE1NDQxMTYz.DGCyiw.MigJWkxAIwwRPNRsIAYdoXMkdZ0")

bot.on(.ready) { [unowned bot] _ in
  bot.editStatus(to: "online", playing: "with Sword!")
  bot.on(.guildAvailable) { data in
    let guild = data as! Guild
    let channels = guild.channels

    let afkChannelId : ChannelID = 206331096864915456
    let hubChannelId : ChannelID = 327485826579824641

    /*func findChannelByName(_ name : String) -> ChannelID{
      for (channelID, channel) in channels{
        if channel.name == name {return channelID}
      }
    }*/

    //mover
    bot.on(.presenceUpdate) { data in
      let (userID, presence) = data as! (UserID, Presence)
      let game = presence.game
      let voiceStates = guild.voiceStates

      if game != nil{
        for (voiceUserID, voiceState) in voiceStates{
          if voiceUserID == userID && voiceState.channelId != afkChannelId {
            for (channelID, channel) in channels {
              if channel.name == game {
                guild.moveMember(userID, to: channelID)
                break
              }/*else{
                guild.createChannel(with : ["type" : 2,"name" : game!])
                guild.moveMember(userID, to : findChannelByName(game!))
                break
              }*/
            }
          }
        }
      }else{
      guild.moveMember(userID, to: hubChannelId)
      }
    }
  }
}

//messager
bot.on(.messageCreate) { data in
  let msg = data as! Message

  if msg.content == "!ping" {
    msg.reply(with: "fuck you")
  }
  if msg.content == "!GoT" {
    msg.reply(with:"Winter is comming,а еще иди нахуй")
  }

}

bot.connect()
