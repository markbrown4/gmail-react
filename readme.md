# ReMail
A React.js tutorial building out a Gmail clone.

http://webdevrefinery.com/forums/topic/13835-reactjs/

Facebook's open source tool for rendering Views that's been generating a heap of noise in the community lately. No prior knowledge of React is necessary.

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
# components/thread_list.cjsx
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

### JSX
JSX compiles a mix of JavaScript and HTML into React calls, e.g.

```jsx
// This JSX
<span className="subject">{text}</span>

// compiles to
React.createElement("span", {"className": "subject"}, text)
```

**C**JSX allows us to use CoffeeScript within curly braces {} rather than JavaScript.

Notice we're using **className** in the place of class, that's because React uses the DOM's property names rather than the HTML attribute names for building these nodes.

## Multiple components

Components can render other components.

```coffee
# components/thread_list.cjsx
ThreadList = React.createClass
  render: ->
    <ul id="threads">
      <ThreadListItem />
    </ul>

ThreadListItem = React.createClass
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
# components/thread_list.cjsx
ThreadList = React.createClass
  getInitialState: ->
    threads: []

  componentDidMount: ->
    reqwest '/api/threads/index.json', (threads)=>
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
    lastMessage = thread.lastMessage

    <li className="unread">
      <a>
        <time>{ lastMessage.createdAt }</time>
        <span className="check"></span>
        <span className="people">
          { for person in thread.participants
            <span className="name unread">
              { person.firstName } { person.lastName }
            </span>
          }
        </span>
        <span className="subject">{ lastMessage.subject }</span>
        <span className="body">- { lastMessage.snippet }</span>
      </a>
    </li>
```

*componentDidMount* is one of Reacts [Lifecycle methods](http://facebook.github.io/react/docs/component-specs.html) that is run just after a component is first rendered in the DOM.  Our ThreadList fetches data from the api, calls setState which re-renders it, this state is passed down to ThreadItem through an attribute(thread) which ThreadItem can access through props(props.thread).

## Toggling state

Let's wire up our checkboxes to toggle a *selected* state on our threads.

React supports all of the usual events, we can listen for them in our components, toggle state and re-render.  http://facebook.github.io/react/docs/events.html

```coffee
# components/thread_list.cjsx
...
ThreadItem = React.createClass
  getInitialState: ->
    selected: false

  select: (event)->
    event.preventDefault()

    @setState selected: !@state.selected

  render: ->
    thread = @props.thread
    lastMessage = thread.lastMessage

    threadClasses = React.addons.classSet
      unread: thread.unread
      selected: @state.selected

    <li className={ threadClasses }>
      <a>
        <time>{ lastMessage.createdAt }</time>
        <span className="check" onClick={@select}></span>
        <span className="people">
          { for person in thread.participants
            <span className="name unread">
              { person.firstName } { person.lastName }
            </span>
          }
        </span>
        <span className="subject">{ lastMessage.subject }</span>
        <span className="body">- { lastMessage.snippet }</span>
      </a>
    </li>
```

*React.addons.classSet* is a handy utility method for adding conditional classes.

## The Magic

If you use your browsers web inspector and watch what happens when you click the checkbox you'll notice that the only thing that changes in the DOM is a single className on the `<li>` nodes.  This is interesting because the render method has been triggered causing the entire component to be re-rendered yet the document remains unchanged except for the specific parts that require updates.

It's this quality that makes React special and it comes with a number of benefits. Because large chunks of the DOM aren't changing when state changes it's faster, allows for css transitions and form elements aren't replaced while being interacted with.

A components render method should not have any side effects, it should take state and props and render the view consistently.

## Communication between components

Let's move our attention to the `<div id="sub-header">` element next, it's state needs to be kept in sync with the main content area - when selecting threads we want our SubHeader to show us tools we can use on that selection.  We also want checking the box in the sub-header to change state on our threads.  The ThreadList and ThreadDetail views also display different content in the SubHeader, there's a few options:

1. We could add a parent component Inbox above our ThreadList and SubHeader to maintain this shared state that can pass data all the way down to SubHeader and Thread through props.
2. SubHeader and ThreadList both have a responsibility to fetch data upon changes and re-render

React encourages us to break down our interface into a hierarchy of small components that given specific props and state render consistently.  Option 1 looks something like this:

```xml
<Inbox>
  <SubHeader />
  <Nav />
  <ThreadList>
    <Thread />
  </ThreadList>
</Inbox>

<ThreadDetail>
  <SubHeader />
  <Nav />
  <ThreadList>
    <Thread />
  </ThreadList>
</ThreadDetail>
```

> For communication between two components that don't have a parent-child relationship, you can set up your own global event system. Subscribe to events in componentDidMount(), unsubscribe in componentWillUnmount(), and call setState() when you receive an event.
> http://facebook.github.io/react/tips/communicate-between-components.html

This(Option 2) seems like a better fit for our SubHeader component, it doesn't tie our data flow to the structure of our HTML(parent > child components) and makes routing simpler - The SubHeader can stay put in a main layout and listen for data changes.

## Flux

This is where things get a little more tricky, Flux is a pattern of single directional data flow.

**Action > Dispatcher > Store > Component**

- Components initiate Actions
- Actions dispatch an event with a unique name and payload
- Stores are our Models/Collections, they listen for dispatched events, update themselves and tell the world that they have changed
- Controller-Views are components that listen for changes on the store, fetch any data they need and pass it down to child components

Our **SubHeader** and **ThreadList** components are example of Controller-Views, it's a regular component that has the special job of fetching data from our Store and wanting to know when it's data changes so it can re-render and flow it's data down through to clild components.

### A basic Flux implementation

*Perhaps Daniel15 can tell us if we're doing anything that isn't The Flux Way™ and we can adapt it.*

A Component initiates an Action
```coffee
# components/thread_list_item.cjsx
ThreadListItem = React.createClass
  select: (event)->
    event.preventDefault()

    InboxActions.toggleSelected(@props.id)

  render: ->
    <span className="check" onClick={@select}></span>

```

Actions dispatch an event with a name and payload
```coffee
# actions.coffee
InboxActions =
  toggleSelected: (id)->
   Dispatcher.trigger 'toggle-selected', id

```

Stores are our Models/Collections, they listen for dispatched events, update themselves and emit that they have changed. Some care is taken to only expose public getters to enforce that all changes happen through dispatched events.

```coffee
# stores/thread_store.coffee
threads = []

@ThreadStore =
  getState: ->
    threads: threads

MicroEvent.mixin(ThreadStore)

toggleSelected = (id)->
  thread = _.find @threads, (thread)-> thread.id == id
  thread.selected = !thread.selected

  @trigger 'change'

Dispatcher.register
  'toggle-selected': (id)-> toggleSelected(id)
```

Controller-Views are components that listen for changes on the store, fetch any data they need and pass it down to child components

```coffee
# components/thread_list.cjsx
ThreadList = React.createClass
  getInitialState: ->
    ThreadStore.getState()

  componentDidMount: ->
    ThreadStore.bind 'change', @onChange

  componentWillUnmount: ->
    ThreadStore.unbind 'change', @onChange

  onChange: ->
    @setState ThreadStore.getState()

  render: ->
    <ul id="threads">
      { for thread in @state.threads
        <ThreadListItem {...thread} />
      }
    </ul>
```

The Dispatcher we'll be using is just an event registry, Stores *register* events they want to know about, Actions *trigger* those events.
```coffee
# dispatcher.coffee
Dispatcher =
  register: (events)->
    for eventName, callback of events
      @bind eventName, callback

MicroEvent.mixin(Dispatcher)
```

> The [Facebook Dispatcher](http://facebook.github.io/flux/docs/actions-and-the-dispatcher.html#content) is quite a different implementation than this, it uses Promises, runs callbacks in order and supports control flow with *waitFor* e.g. Store A can wait Store B's callbacks to run before it's own.

And that's it, a wonderfully naive implementation of Flux.

## Routing

[react-router]() seems to be the most popular solution for routing in React apps so we'll focus on that.

