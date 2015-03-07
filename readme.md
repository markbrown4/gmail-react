# ReMail
A React.js tutorial building out a Gmail clone.

http://webdevrefinery.com/forums/topic/13835-reactjs/

## Tutorial

### Our first component

Let's remove the entire <ul id="threads"> element from *index.html* and make a React component to build it dynamically.

```
# app.cjsx
ThreadList = React.createClass
  render: ->
    <ul id="threads">
      <li className="unread">
        <a>
          <time>Aug 30</time>
          <span className="check"></span>
          <span className="people">
            <span className="name unread">Beatrix Kiddo</span>
          </span>
          <span className="subject">My fox force five joke</span>
          <span className="body">- Vincent, You still wanna hear it?</span>
        </a>
      </li>
    </ul>

React.render <ThreadList />, document.getElementById('content')
```

At it's simplest *React.createClass* takes an object with a render function and returns a single root element.

JSX compiles a mix of JavaScript and HTML into React calls, e.g. `<span className="subject">{text}</span>` compiles to `React.createElement("span", {"className": "subject"}, text)`

This is simpler than writing the raw React calls and **C***JSX allows us to use CoffeeScript within curly braces {} rather than JavaScript.

Notice we're using 'className' in the place of class, that's because React uses the DOM's property names rather than the HTML attribute names for building these nodes.

### Multiple components

Components can render other components.

```
# app.coffee
ThreadList = React.createClass
  render: ->
    <ul id="threads">
      <ThreadItem />
    </ul>

ThreadItem = React.createClass
  render: ->
    <li className="unread">
      <a>
        <time>Aug 30</time>
        <span className="check"></span>
        <span className="people">
          <span className="name unread">Beatrix Kiddo</span>
        </span>
        <span className="subject">My fox force five joke</span>
        <span className="body">- Vincent, You still wanna hear it?</span>
      </a>
    </li>

React.render <ThreadList />, document.getElementById('content')
```

### Making it dynamic

Data in stored in a components *props* and *state* objects, when either of these objects are modified through setState() or setProps() a re-render is triggered.

> Most of your components should simply take some data from props and render it.
> State should contain data that a component's event handlers may change to trigger a UI update.

```
ThreadList = React.createClass
  getInitialState: ->
    threads: []

  componentDidMount: ->
    $.ajax(
      url: '/api/threads/index.json'
      cache: false
    ).then (threads)=>
      @setState threads: threads

  render: ->
    <ul id="threads">
      { for thread in @state.threads
        <ThreadItem thread={thread} />
      }
    </ul>

ThreadItem = React.createClass
  render: ->
    thread = @props.thread
    lastMessage = thread.last_message

    <li className="unread">
      <a>
        <time>{ lastMessage.created_at }</time>
        <span className="check"></span>
        <span className="people">
          { for person in thread.participants
            <span className="name unread">{ person.first_name } { person.last_name }</span>
          }
        </span>
        <span className="subject">{ lastMessage.subject }</span>
        <span className="body">- { lastMessage.snippet }</span>
      </a>
    </li>
```

*componentDidMount* is run when our ThreadList is initially rendered, it fetches data from the api and calls setState causing it to re-render. ThreadList then passes this data through an attribute which ThreadItem can access through props.

### Toggling state

Let's wire up our checkboxes to toggle a *selected* state on our threads.
```
ThreadItem = React.createClass
  getInitialState: ->
    selected: false

  select: (event)->
    event.preventDefault()

    @setState selected: !@state.selected

  render: ->
    ...
    <span className="check" onClick={@select}></span>
    ...
```

React supports all of the usual event listeners, interestingly touch events must be explicitly enabled.
http://facebook.github.io/react/docs/events.html

### The magic

If you use your browsers web inspector and watch what happens when you click the checkbox you'll notice that the only thing that changes in the DOM is a single className on the <li>'s.  This is interesting because the render method has been triggered causing the entire component to be re-rendered yet the document remains unchanged except for the specific parts that require updates.

It's this quality that makes react special and it comes with a number of benefits. Because large chunks of the DOM aren't changing when state changes it's faster, allows for css transitions and form elements aren't replaced while being interacted with.
