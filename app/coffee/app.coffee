
Thread = React.createClass
  render: ->
    <li class="unread">
      <a href>
        <time>Aug 30</time>
        <span className="check"></span>
        <span className="people">
          <span className="name unread">Beatrix Kiddo</span>
        </span>
        <span className="subject">My fox force five joke</span>
        <span className="body">- Vincent, You still wanna hear it?</span>
      </a>
    </li>

$threads = document.getElementById('threads')
React.render <Thread />, $threads
