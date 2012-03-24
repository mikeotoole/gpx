class App.Views.Rides.PaceChartView extends Backbone.View
  events:
    'click .menu a': 'selectChart'

  availableCharts:
    [
      {
        name: 'Distance'
        rel: 'distance'
      },
      {
        name: 'Elapsed Time'
        rel: 'elapsedTime'
      }
    ]

  initialize: (options) ->
    @points = options.points

  render: =>
    $(@el).find('.menu').html JST['templates/rides/chart_menu_view'](charts: @availableCharts)
    @renderChart _.first(@availableCharts).rel
    @

  renderChart: (type) =>
    chart = new Highcharts.Chart(@["#{type}ChartOptions"]())
    $(@el).find('.menu a.selected').removeClass('selected')
    $(@el).find(".menu a[rel='#{type}']").addClass('selected')

  selectChart: (event) =>
    event.preventDefault()
    @renderChart $(event.target).closest('a').attr('rel')

  distanceDataPoints: =>
    distances = []
    paces = []

    @points.each (point) =>
      if point.isActive()
        distances.push App.Helpers.metersToMiles(point.get('distance'))
        paces.push App.Helpers.secondsPerMeterToMinutesPerMile(point.get('pace'))

    _.zip distances, App.Helpers.movingAverage(paces)

  elapsedTimeDataPoints: =>
    times = []
    paces = []

    @points.each (point) =>
      if point.isActive()
        time = point.get('active_duration') * 1000

        if time > 0
          times.push time
          paces.push App.Helpers.secondsPerMeterToMinutesPerMile(point.get('pace'))

    _.zip times, App.Helpers.movingAverage(paces)

  distanceChartOptions: =>
    _.extend @commonChartOptions(), {
      xAxis:
        title:
          text: ''
      tooltip:
        formatter: ->
          "<strong>Distance:</strong>#{Highcharts.numberFormat(this.x, 1)} mi<br><strong>Pace:</strong>#{App.Helpers.formatTime(this.y * 60)} per mile"
      series: [
        _.extend @commonSeriesOptions(), {data: @distanceDataPoints()}
      ]
    }

  elapsedTimeChartOptions: =>
    _.extend @commonChartOptions(), {
      xAxis:
        title:
          text: ''
        type: 'datetime'
      tooltip:
        formatter: ->
          "<strong>Elapsed Time:</strong>#{App.Helpers.formatTime(this.x / 1000)}<br><strong>Pace:</strong>#{App.Helpers.formatTime(this.y * 60)} per mile"
      series: [
        _.extend @commonSeriesOptions(), {data: @elapsedTimeDataPoints()}
      ]
    }

  commonChartOptions: =>
    chart:
      renderTo: $(@el).find('.highchart').get(0)
    yAxis:
      min: 0
      title:
        text: 'Pace (min/mile)'

  commonSeriesOptions: =>
    marker:
      enabled: false
      fillColor: '#444'
      symbol: 'circle'
      radius: 4
      lineWidth: 2
      states:
        hover:
          enabled: true
    lineWidth: 3
    shadow: false
    states:
      hover:
        lineWidth: 3
    name: 'Pace'
