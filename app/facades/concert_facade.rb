class ConcertFacade
  def get_top_concert(artist)
    json = TicketMasterService.get_events(artist)
    first_event = json[:_embedded][:events][0]
    Concert.new(first_event)
  end
end