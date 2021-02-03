# fromthepage-client
Clients for interacting with the FromThePage APIs

# Usage
Download the client and run it from the command line.  It requires ruby and curl.  We tested with ruby 2.6.0, but most should work.

Run it with your [API key](https://content.fromthepage.com/project-owner-documentation/api-keys/), your user slug, and an existing backup directory.  Your user slug is the part of the FromThePage URL for any of your projects, i.e. 
`benwbrum` in the following URL `https://fromthepage.com/benwbrum/jeremiah-white-graves-diaries`.

`ruby full_export.rb KEY SLUG OUTPUT_DIRECTORY`

i.e.
`ruby full_export.rb 2K59hIdQhKfDDQoBMvnXiAtt benwbrum backups`

# Sponsorship
The team is grateful to the Beinecke Library at Yale University for support of this feature.


