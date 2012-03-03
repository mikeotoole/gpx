class App.Routers.ApplicationRouter extends Backbone.Router
  routes:
    '': 'index'
    'rides': 'rides'
    'rides/:id': 'ride'

  index: =>
    $('#container').empty()

    summaryView = new App.Views.Summary.SummaryView(collection: App.segments)
    $('#container').append summaryView.render().el

  rides: =>
    $('#container').empty()

    segmentsView = new App.Views.Segments.SegmentsView(collection: App.segments)
    $('#container').append segmentsView.render().el

  ride: (id) =>
    $('#container').empty()

    segment = App.segments.get(id)
    segmentView = new App.Views.Segments.SegmentView(model: segment)
    $('#container').append segmentView.render().el