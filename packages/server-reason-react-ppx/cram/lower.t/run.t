  $ ../ppx.sh --output re input.re
  let lower = React.createElement("div", [], []);
  let lower_empty_attr =
    React.createElement(
      "div",
      List.filter_map(
        Fun.id,
        [Some([@implicit_arity] React.JSX.String("class", "": string))],
      ),
      [],
    );
  let lower_inline_styles =
    React.createElement(
      "div",
      List.filter_map(
        Fun.id,
        [
          Some(
            React.JSX.Style(
              ReactDOM.Style.to_string(
                ReactDOM.Style.make(~backgroundColor="gainsboro", ()): ReactDOM.Style.t,
              ),
            ),
          ),
        ],
      ),
      [],
    );
  let lower_inner_html =
    React.createElement(
      "div",
      List.filter_map(Fun.id, [Some(React.JSX.DangerouslyInnerHtml(text))]),
      [],
    );
  let lower_opt_attr =
    React.createElement(
      "div",
      List.filter_map(
        Fun.id,
        [
          Option.map(
            v =>
              [@implicit_arity] React.JSX.String("tabindex", string_of_int(v)),
            tabIndex: option(int),
          ),
        ],
      ),
      [],
    );
  let lowerWithChildAndProps = foo =>
    React.createElement(
      "a",
      List.filter_map(
        Fun.id,
        [
          Some(
            [@implicit_arity]
            React.JSX.String("tabindex", string_of_int(1: int)),
          ),
          Some(
            [@implicit_arity]
            React.JSX.String("href", "https://example.com": string),
          ),
        ],
      ),
      [foo],
    );
  let lower_child_static =
    React.createElement("div", [], [React.createElement("span", [], [])]);
  let lower_child_ident = React.createElement("div", [], [lolaspa]);
  let lower_child_single =
    React.createElement("div", [], [React.createElement("div", [], [])]);
  let lower_children_multiple = (foo, bar) =>
    React.createElement("lower", [], [foo, bar]);
  let lower_child_with_upper_as_children =
    React.createElement(
      "div",
      [],
      [React.Upper_case_component(() => App.make())],
    );
  let lower_children_nested =
    React.createElement(
      "div",
      List.filter_map(
        Fun.id,
        [
          Some(
            [@implicit_arity]
            React.JSX.String("class", "flex-container": string),
          ),
        ],
      ),
      [
        React.createElement(
          "div",
          List.filter_map(
            Fun.id,
            [
              Some(
                [@implicit_arity] React.JSX.String("class", "sidebar": string),
              ),
            ],
          ),
          [
            React.createElement(
              "h2",
              List.filter_map(
                Fun.id,
                [
                  Some(
                    [@implicit_arity]
                    React.JSX.String("class", "title": string),
                  ),
                ],
              ),
              ["jsoo-react" |> s],
            ),
            React.createElement(
              "nav",
              List.filter_map(
                Fun.id,
                [
                  Some(
                    [@implicit_arity] React.JSX.String("class", "menu": string),
                  ),
                ],
              ),
              [
                React.createElement(
                  "ul",
                  [],
                  [
                    examples
                    |> List.map(e =>
                         React.createElement(
                           "li",
                           List.filter_map(
                             Fun.id,
                             [
                               Some(
                                 [@implicit_arity]
                                 React.JSX.String("key", e.path: string),
                               ),
                             ],
                           ),
                           [
                             React.createElement(
                               "a",
                               List.filter_map(
                                 Fun.id,
                                 [
                                   Some(
                                     [@implicit_arity]
                                     React.JSX.String("href", e.path: string),
                                   ),
                                   Some(
                                     [@implicit_arity]
                                     React.JSX.Event(
                                       "onClick",
                                       React.JSX.Mouse(
                                         event => {
                                           React.Event.Mouse.preventDefault(
                                             event,
                                           );
                                           ReactRouter.push(e.path);
                                         }: React.Event.Mouse.t => unit,
                                       ),
                                     ),
                                   ),
                                 ],
                               ),
                               [e.title |> s],
                             ),
                           ],
                         )
                       )
                    |> React.list,
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  let lower_ref_with_children =
    React.createElement(
      "button",
      List.filter_map(
        Fun.id,
        [
          Some(React.JSX.Ref(ref: React.domRef)),
          Some(
            [@implicit_arity] React.JSX.String("class", "FancyButton": string),
          ),
        ],
      ),
      [children],
    );
  let lower_with_many_props =
    React.createElement(
      "div",
      List.filter_map(
        Fun.id,
        [
          Some([@implicit_arity] React.JSX.String("translate", "yes": string)),
        ],
      ),
      [
        React.createElement(
          "picture",
          List.filter_map(
            Fun.id,
            [
              Some(
                [@implicit_arity] React.JSX.String("id", "idpicture": string),
              ),
            ],
          ),
          [
            React.createElement(
              "img",
              List.filter_map(
                Fun.id,
                [
                  Some(
                    [@implicit_arity]
                    React.JSX.String("src", "picture/img.png": string),
                  ),
                  Some(
                    [@implicit_arity]
                    React.JSX.String("alt", "test picture/img.png": string),
                  ),
                  Some(
                    [@implicit_arity] React.JSX.String("id", "idimg": string),
                  ),
                ],
              ),
              [],
            ),
            React.createElement(
              "source",
              List.filter_map(
                Fun.id,
                [
                  Some(
                    [@implicit_arity]
                    React.JSX.String("type", "image/webp": string),
                  ),
                  Some(
                    [@implicit_arity]
                    React.JSX.String("src", "picture/img1.webp": string),
                  ),
                ],
              ),
              [],
            ),
            React.createElement(
              "source",
              List.filter_map(
                Fun.id,
                [
                  Some(
                    [@implicit_arity]
                    React.JSX.String("type", "image/jpeg": string),
                  ),
                  Some(
                    [@implicit_arity]
                    React.JSX.String("src", "picture/img2.jpg": string),
                  ),
                ],
              ),
              [],
            ),
          ],
        ),
      ],
    );
  let some_random_html_element =
    React.createElement(
      "text",
      List.filter_map(
        Fun.id,
        [
          Some([@implicit_arity] React.JSX.String("dx", "1 2": string)),
          Some([@implicit_arity] React.JSX.String("dy", "3 4": string)),
        ],
      ),
      [],
    );
  let div =
    React.createElement(
      "div",
      List.filter_map(
        Fun.id,
        [
          Option.map(
            v =>
              [@implicit_arity] React.JSX.Event("onClick", React.JSX.Mouse(v)),
            onClick: option(React.Event.Mouse.t => unit),
          ),
        ],
      ),
      [],
    );
