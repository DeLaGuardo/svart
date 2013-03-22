window.TEMPLATES =
  tellError:'<div id="tell-error" class="-modal" style="min-width: 400px">  <form class="-modal-content -form _vertical_">   <label>Page</label>   <span class="-form-field">    <input type="text" id="tell-error-page" class="-col4"/>   </span>      <label>What is wrong?</label>   <span class="-form-field">    <textarea id="tell-error-body" class="-col4" rows="8"></textarea>   </span>      <label>How it should be?</label>   <span class="-form-field">    <textarea id="tell-error-shouldbe" class="-col4" rows="8"></textarea>   </span>      <label>Few comments</label>   <span class="-form-field">    <input type="text" id="tell-error-why" class="-col4"/>   </span>       <br>   <br>     <div id="tell-error-buttons">    <a class="-btn" id="tell-error-send">Send</a> <a class="-btn -error- -unstyled- -closer">Cancel</a>   </div>  </form> </div>'
  statuses:"{{name}}"
  size:"{{name}}"
  modificator:'{{name}} <i class="{{icon}}"></i>'
  modalVideo:'<div class="-modal js-modal-video" style="backface-visibility:hidden; -webkit-backface-visibility:hidden; -moz-backface-visibility:hidden;">     <iframe width="640" height="480" src="http://www.youtube.com/embed/S81bLIcNTzc" frameborder="0" allowfullscreen></iframe>   </div>'
  matter:"{{name}}"
  indexPageTooltip:'<div class="-tooltip" style="text-align:center"><i class="-arrow"></i><span class="js-content">Tooltip</span></div>'
  error:'<td>{{page}}</td> <td>{{error}}</td> <td>{{correct}}</td> <td>{{why}}</td> <td>  <a class="-btn -error- _small js-fix"><i class="-icon-remove"></i></a> </td>'
  dropdownMainMenu:'<div class="-dropdown -dark-">  <i class="-arrow"></i>  <div class="js-content"></div> </div>'
  code:
    toolbar:'<div class="-toolbar">  <a class="-btn"><i class="-icon-print"></i></a>  <a class="-btn"><i class="-icon-arrow-left"></i></a>  <a class="-btn"><i class="-icon-arrow-right"></i></a>    <a class="-btn">Header 1 <i class="-caret"></i></a>    <a class="-btn"><i class="-icon-font"></i></a>  <a class="-btn"><i class="-icon-bold"></i></a>  <a class="-btn"><i class="-icon-italic"></i></a>    <div class="-group">   <a class="-btn"><i class="-icon-align-left"></i></a>   <a class="-btn"><i class="-icon-align-center"></i></a>   <a class="-btn"><i class="-icon-align-right"></i></a>   <a class="-btn"><i class="-icon-align-justify"></i></a>  </div>      <div class="-group -form">   <input type="text" value="12" style="width: 50px">   <a class="-btn"><i class="-caret"></i></a>  </div> </div>'
    tabs:'<small>Drag modificators on <i>first</i> tab to apply tabs element</small> <ul class="-tabs">  <li class="_active_">   <a>Tab</a>  </li>  <li>   <a>Tab <i class="-caret"></i></a>  </li>  <li>   <a>Tab <i class="-icon-thumbs-up"></i></a>  </li>  <li>   <a>Tab</a>  </li>  <li>   <a>Tab</a>  </li> </ul>'
    table:'<small>Drag modificators on <i>thead</i> to apply it to all table, or on numbers to apply it to row</small> <table class="-table">  <thead>   <tr>    <th>#</th>    <th>name</th>    <th>nikname</th>    <th>email</th>   </tr>  </thead>  <tbody>   <tr>    <td>1</td>    <td>Maxim</td>    <td>maxmert</td>    <td>me@maxmert.com</td>   </tr>   <tr>    <td>2</td>    <td>Sergey</td>    <td>sergy</td>    <td>me@sergey.com</td>   </tr>   <tr>    <td>3</td>    <td>Elon</td>    <td>el</td>    <td>me@el.com</td>   </tr>  </tbody> </table>'
    progressbar:'<small>Drag modificators on progressbar"s <i>empty</i> place after bars to apply it to whole progressbar</small> <div class="-progress _small _loading_" style="width: 100%">  <div class="-progress-bar" style="width: 55%">   file 1 - 55%  </div>  <div class="-progress-bar" style="width: 25%">   file 2 - 25%  </div>  <div class="-progress-bar-global -info-" style="width: 12%">   global - 12%  </div> </div>'
    menuDropdown:'<small>Drag modificators on <i>first</i> menu element to apply it to all menu</small> <div class="-dropdown -primary- _top_">  <i class="-arrow"></i>  <ul class="-menu -primary-">   <li><a><i class="-icon-thumbs-up"></i> I like it</a></li>   <li><a><i class="-icon-star"></i> Favourite</a></li>   <li><a><i class="-icon-thumbs-down"></i> I hate it</a></li>   <li class="-menu-sub"><a><i class="-icon"></i> Share</a>    <div class="-dropdown">     <ul class="-menu">      <li><a><i class="-icon"></i> Facebook</a></li>      <li class="-success-"><a><i class="-icon-ok-circle"></i> Twitter</a></li>      <li><a><i class="-icon"></i> My space</a></li>     </ul>    </div>   </li>   <li class="-menu-separator"></li>   <li class="-error-"><a><i class="-icon-remove"></i> Don"t show me this</a></li>  </ul> </div>'
    menu:'<small>Drag modificators on <i>first</i> menu element to apply it to all menu</small> <ul class="-menu _active_">  <li><a>Menu item</a></li>  <li class="-error-"><a>Error item</a></li>  <li><a>Item width submenu</a>   <div class="-dropdown">    <ul class="-menu">     <li><a>Menu item</a></li>     <li class="-success-"><a>Success item</a></li>     <li class="-menu-sub"><a>Item with submenu</a>      <div class="-dropdown">       <ul class="-menu">        <li class="-error- -disabled-"><a>Disabled error item</a></li>        <li><a><span class="-menu-help">T</span>Item with help information</a></li>       </ul>      </div>     </li>     <li><a><span class="-menu-help">M</span>Default item with help information</a></li>    </ul>   </div>  </li> </ul>'
    label:'<span class="-label">label</span>'
    input:'<form class="-form">  <span class="-form-field">   <input type="text" value="# TODO: Create margin: 0">  </span> </form>'
    groupInput:'<small>Drag modificators on <i>first</i> element of the group to apply it to all group</small> <div class="-group -form">  <a class="-btn">Button</a><a class="-btn">Button</a><a class="-btn">button</a><span class="-group-appendix">text</span><input type="text" value="input"> </div>'
    groupCaret:'<small>Drag modificators on <i>first</i> button of the group to apply it to all group</small> <a class="-btn">Dropdown <i class="-caret"></i></a> &nbsp;&nbsp; <div class="-group">  <a class="-btn">Dropdown</a><a class="-btn"><i class="-caret"></i></a> </div>'
    groupButtons:'<small>Drag modificators on <i>first</i> button of the group to apply it to all group</small> <div class="-group">  <a class="-btn">I like it</a><a class="-btn"><i class="-icon-thumbs-up"></i></a> </div> <div class="-group">  <a class="-btn">Favourite</a><a class="-btn"><i class="-icon-star"></i></a> </div> <div class="-group">  <a class="-btn">Repeat</a><a class="-btn -warning-"><i class="-icon-repeat -icon-light-"></i></a> </div>'
    formVertical:'<form class="-form _vertical_">  <label>Login</label>  <span class="-form-field">   <input type="text">  </span>  <span class="-form-field-help">Help me with this field</span>   <label>Password</label>  <span class="-form-field">   <input type="text">  </span>   <label>Short bio</label>  <span class="-form-field">   <textarea></textarea>  </span>    <label>   <a class="-btn">Save</a>    <a class="-btn -error- -unstyled-">Cancel</a>  </label>  </form>'
    formHorizontal:'<form class="-form _horizontal_">  <div class="-form-row">   <label>Login</label>   <span class="-form-field -col3">    <input type="text" value="-col3">   </span>   <span class="-form-field-help">Help me with this field</span>  </div>   <div class="-form-row">   <label>Password</label>   <span class="-form-field -col1">    <input type="text" value="-col1">   </span>   <span class="-form-field -col2">    <input type="text" value="-col2">   </span>  </div>   <div class="-form-row">   <label>Country</label>   <span class="-form-field -col3">    <select>     <option>Russia</option>     <option>USA</option>     <option>Germany</option>    </select>    <i class="-caret"></i>   </span>  </div>   <div class="-form-row">   <div class="-form-group">    <label>     <input type="checkbox"> Remember me    </label>   </div>  </div>   <div class="-form-row">   <div class="-form-group">    <a class="-btn">Enter</a> <a class="-btn -error-">Reset</a>   </div>  </div>  </form>'
    dropdown:'<div class="-dropdown">  <div class="-dropdown-header">Header</div>  <div class="-dropdown-content">Content of dropdown</div> </div> &nbsp; <div class="-dropdown -dark- _left_">  <i class="-arrow"></i>  <div class="-dropdown-content">Dropdown</div> </div> &nbsp; <div class="-dropdown -primary- _top_">  <div class="-arrow"></div>  <div class="-dropdown-header">Header</div>  <div class="-dropdown-content">Content</div> </div>'
    button:'<a class="-btn">Button</a>'
    badge:'<span class="-badge">badge</span>'

window.getTemplate = (params) ->

window.setCalendar = ->
  date = new Date()
  d = date.getDate()
  m = date.getMonth()
  y = date.getFullYear()
  calendar = $("#calendar").fullCalendar(
    header:
      left: "prev,next today"
      center: "title"
      right: "month,agendaWeek,agendaDay"

    selectable: true
    selectHelper: true
    select: (start, end, allDay) ->
      title = prompt("Event Title:")
      if title
        calendar.fullCalendar "renderEvent",
          title: title
          start: start
          end: end
          allDay: allDay
        , true # make the event "stick"
      calendar.fullCalendar "unselect"

    editable: true
    events: [
      title: "All Day Event"
      start: new Date(y, m, 1)
    ,
      title: "Long Event"
      start: new Date(y, m, d - 5)
      end: new Date(y, m, d - 2)
    ,
      id: 999
      title: "Repeating Event"
      start: new Date(y, m, d - 3, 16, 0)
      allDay: false
    ,
      id: 999
      title: "Repeating Event"
      start: new Date(y, m, d + 4, 16, 0)
      allDay: false
    ,
      title: "Meeting"
      start: new Date(y, m, d, 10, 30)
      allDay: false
    ,
      title: "Lunch"
      start: new Date(y, m, d, 12, 0)
      end: new Date(y, m, d, 14, 0)
      allDay: false
    ,
      title: "Birthday Party"
      start: new Date(y, m, d + 1, 19, 0)
      end: new Date(y, m, d + 1, 22, 30)
      allDay: false
    ,
      title: "Click for Google"
      start: new Date(y, m, 28)
      end: new Date(y, m, 29)
      url: "http://google.com/"
    ]
  )
