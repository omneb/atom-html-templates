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
      expect(editor.getText()).toEqual("There is no such option.")

  it " html5 text", ->
      editor = atom.workspace.getActiveTextEditor()
      editor.insertText(html5)
      editor.selectAll()

      atom.commands.dispatch workspaceElement, 'atom-html-templates:toggle'

      waitsForPromise ->
        activationPromise

      runs ->
        expect(editor.getText().replace /\s+/g, '').toEqual """
           <!DOCTYPE html>
           <html lang="en">

          <head>
               <meta charset="UTF-8">
               <title>TITLE</title>
               <meta name="description" content="DESCRIPTION">
              <link rel="stylesheet" href="PATH">

               <!--[if lt IE 9]>
                 <script src = "http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
               <![endif]-->
           </head>

           <body>

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
