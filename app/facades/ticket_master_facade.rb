class TicketMasterFacade
  def get_artist_events(artist)
    json = TicketMasterService.get_events(artist)

    json[:_embedded][:events].map do |event_data|
      Event.new(event_data)
    end
  end
end