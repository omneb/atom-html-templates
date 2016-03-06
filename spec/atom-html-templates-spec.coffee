AtomHtmlTemplates = require '../lib/atom-html-templates'



describe "AtomHtmlTemplates", ->
  text =null
  html5 = "html5"
  [workspaceElement, activationPromise] = []

  beforeEach ->
    workspaceElement = atom.views.getView(atom.workspace)
    activationPromise = atom.packages.activatePackage('atom-html-templates')

    waitsForPromise ->
      atom.workspace.open()

  it "check null text in editor", ->
    expect(text).toEqual(null)

  it "default text", ->
    editor = atom.workspace.getActiveTextEditor()
    editor.selectAll()

    atom.commands.dispatch workspaceElement, 'atom-html-templates:toggle'

    waitsForPromise ->
      activationPromise

    runs ->
      expect(editor.getText()).toEqual("nie ma takiej opcji")

  it " html5 text", ->
      editor = atom.workspace.getActiveTextEditor()
      editor.insertText(html5)
      editor.selectAll()

      atom.commands.dispatch workspaceElement, 'atom-html-templates:toggle'

      waitsForPromise ->
        activationPromise

      runs ->
        expect(editor.getText().replace /\s+/g, '').toEqual """
          <!doctype html>
          <html lang="en">
          <head>
            <meta charset ="utf-8">

            <title>Title of your project</title>
            <meta name = "description" content="The HTML5 Herald">
            <meta name = "author" content="SitePoint">

            <link rel = "stylesheet" href="css/styles.css?v=1.0">

            <!--[if lt IE 9]>
            <script src = "http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
            <![endif]-->
          </head>
          <body>
            <script src = "js/scripts.js"></script>
          </body>
          </html>
        """.replace /\s+/g, ''
    it " bootstrap-foundation text", ->
        editor = atom.workspace.getActiveTextEditor()
        editor.insertText('html5-bootstrap-foundation')
        editor.selectAll()

        editor2 = atom.workspace.getActiveTextEditor()
        editor2.insertText('html5-foundation-bootstrap')
        editor2.selectAll()

        atom.commands.dispatch workspaceElement, 'atom-html-templates:toggle'

        waitsForPromise ->
          activationPromise

        runs ->
          expect(editor.getText().replace /\s+/g, '').toEqual (editor2.getText().replace /\s+/g, '')
