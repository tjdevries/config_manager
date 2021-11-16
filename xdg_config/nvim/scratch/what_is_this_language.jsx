function tick() {
  const element = (
    <div>
      <h1>Hello, world!</h1>

      <h2>It is {new Date().toLocaleTimeString()}.</h2>
    </div>
  );
  ReactDOM.render(element, document.getElementById('root'));
}
//
// When only attribute is on the line, then `//%s` is used.
export function Element() {
  return (
    <div>
    <div>
      <h1
        id="foo"
        class="lsp"
        data-telescope="good"
      >
        Hello, world!
     </h1>
    </div>
    </div>
  );
}

// When attribute is on the same line as element, then `/*%s*/` is used.
export function Element() {
  return (
    <div>
      <h1 /* id="foo" class="lsp" */ data-telescope="good" >
        Hello, world!
      </h1>
    </div>
  );
}

// For element, then `{/*%s*/}` is used.
export function Element() {
  return (
    <div>
      <h1 id="foo" class="lsp" data-telescope="good" >
        Hello, world!
      </h1>
    </div>
  );
}
