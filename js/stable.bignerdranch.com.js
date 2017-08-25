function addAcknowledgeAllButton() {
  var acknowledgeButtons = () => $('a[rel~="acknowledge-result"]')
  if (acknowledgeButtons().length) {
    $('a[rel="new-result"]')
    .before('<a class="btn btn-primary" id="jws-ack-all">Acknowledge All Visible Results</a> ')

    $('#jws-ack-all').click(function() {
      // Implicit iteration with collection.click() didn't seem to work right
      // as of 2016-09-26.
      var ackd = acknowledgeButtons().each((i, el) => el.click())
      alert(`Acknowledged ${ackd.length} results.`)
    })
  }
}

function boldCurrentOrNearestCurrentResult() {
  var items = $('table.results tr')
    .filter((i, el) => { return !!$(el).data('start-date') })
    .map((i, el) => {
      let $el = $(el)
      let kids = $el.children('td')
      let start = new Date($(kids[0]).text())
      let end = new Date($(kids[1]).text())
      return {el: $el, start: start, end: end}
    })
  var today = new Date()
  var started = items.filter((i, item) => item.start < today)
  var latest = started.sort((left, right) => right.start - left.start)[0]
  latest.el.css('font-weight', 'bold')
}

addAcknowledgeAllButton()
boldCurrentOrNearestCurrentResult()
