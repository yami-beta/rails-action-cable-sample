class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message)
    match_data = /\A@(?<username>\w+)\s/.match(message.content)
    if !match_data
      RoomChannel.broadcast_to("all", message: render_message(message))
      # ActionCable.server.broadcast 'room:all', message: render_message(message)
      return
    end

    username = match_data[:username]
    user = User.find_by(username: username)
    if user
      RoomChannel.broadcast_to(user.id, message: render_message(message))
    else
      RoomChannel.broadcast_to("all", message: render_message(message))
      # ActionCable.server.broadcast 'room:all', message: render_message(message)
    end
  end

  private

  def render_message(message)
    ApplicationController.renderer.render(partial: 'messages/message', locals: { message: message })
  end
end
