# ReMail
A React.js tutorial building out a Gmail clone.

http://webdevrefinery.com/forums/topic/13835-reactjs/

In this tutorial we'll be looking at how to build rich client-side apps using React.js, Facebook's open source tool for rendering Views that's been generating a heap of noise in the community lately. No prior knowledge of React is necessary.

## Prerequisites

You'll need npm installed and an intermediate knowledge of JavaScript and a tolerance or love of CoffeeScript.

## Install
```
git clone https://github.com/markbrown4/gmail-react
cd gmail-react
git checkout origin/start
npm start
```
In a separate process watch our assets for changes
```
npm run assets
```
Hit http://localhost:8000/ in your favourite browser and you should see a bunch of familiar Gmail elements on the screen - you'll be bringing that static page to life and responding to events, just like Pinocchio.

## Our first component

Let's remove the entire `<ul id="threads">` element from *index.html* and make a React component to build it dynamically.

```coffee
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

JSX compiles a mix of JavaScript and HTML into React calls, e.g.

```jsx
// This JSX
<span className="subject">{text}</span>

// compiles to
React.createElement("span", {"className": "subject"}, text)
```

This is simpler than writing the raw React calls and **C**JSX allows us to use CoffeeScript within curly braces {} rather than JavaScript.

Notice we're using **className** in the place of class, that's because React uses the DOM's property names rather than the HTML attribute names for building these nodes.

## Multiple components

Components can render other components.

```coffee
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

## Making it dynamic

Data is stored in a components *props* and *state* objects, when either of these objects are modified through setState() or setProps() a re-render is triggered.

> Most of your components should simply take some data from props and render it.
> State should contain data that a component's event handlers may change to trigger a UI update.

```coffee
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
            <span className="name unread">
              { person.first_name } { person.last_name }
            </span>
          }
        </span>
        <span className="subject">{ lastMessage.subject }</span>
        <span className="body">- { lastMessage.snippet }</span>
      </a>
    </li>
```

*componentDidMount* is run when our ThreadList is initially rendered, it fetches data from the api and calls setState causing it to re-render. ThreadList then passes this data through an attribute which ThreadItem can access through props.

## Toggling state

Let's wire up our checkboxes to toggle a *selected* state on our threads.

React supports all of the usual events, we can listen for them in our components, toggle state and re-render.  http://facebook.github.io/react/docs/events.html

```coffee
ThreadItem = React.createClass
  getInitialState: ->
    selected: false

  select: (event)->
    event.preventDefault()

    @setState selected: !@state.selected

  render: ->
    ...
    threadClasses = React.addons.classSet
      unread: thread.unread
      selected: @state.selected

    <li className={ threadClasses }>
      ...
      <span className="check" onClick={@select}></span>
      ...
```

**React.addons.classSet** is a handy utility method for adding conditional classes.

## The magic

If you use your browsers web inspector and watch what happens when you click the checkbox you'll notice that the only thing that changes in the DOM is a single className on the `<li>` nodes.  This is interesting because the render method has been triggered causing the entire component to be re-rendered yet the document remains unchanged except for the specific parts that require updates.

It's this quality that makes React special and it comes with a number of benefits. Because large chunks of the DOM aren't changing when state changes it's faster, allows for css transitions and form elements aren't replaced while being interacted with.

A components render method should not have any side effects, it should take state and props and render the view consistently.

## Communication between components

Let's move our attention to the `<div id="sub-header">` element next, when selecting threads we want our SubHeader to show us tools we can use on that selection.  We also want checking the box in the sub-header to change state on our threads.
This tells us we need a component above our ThreadList and SubHeader to maintain this shared state and that we should pull it out of ThreadItem's state and instead pass it from Inbox all the way down to Thread through props.

React encourages us to break down our interface into a hierarchy of small components that take data and state and render. We'll make an Inbox component that holds the state for selected threads and passes it down to the SubHeader and ThreadList components through props.

```
<Inbox>
  <SubHeader />
  <Nav />
  <ThreadList>
    <Thread />
  </ThreadList>
</Inbox>
```
> For communication between two components that don't have a parent-child relationship, you can set up your own global event system. Subscribe to events in componentDidMount(), unsubscribe in componentWillUnmount(), and call setState() when you receive an event.
> http://facebook.github.io/react/tips/communicate-between-components.html

### Flux

A pattern of single directional data flow.

Action > Dispatcher > Store > View

Views trigger an Action
Actions dispatch an event with a name and payload
Stores listen for those events, update themselves and emit that they have changed
Views that rely on those stores listen for changes and fetch the data that they need and re-render

Our **Inbox** component is an example of a Controller-View, it's a regular component that has the special job of fetching data from our Store wanting to know when it's data changes so it can re-render and flow it's data down through to clild components.

