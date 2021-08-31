# EDR Activity Generator

This is a configurable utility designed to generate specific types of activity
on host systems.  This provides the information a new version of an install
Endpoint Detection and Response (EDR) agent to be tested in order to ensure it
generates the correct telemtry.

## Installation

The activity generator is designed to be packaged and distributed as a gem to
allow for easily installation across different platforms.  It is current *not*
published on rubygems.org because it is a reference project only.

This project requires Ruby 3.0+, including its pre-installed bundler gem, as
well as git.

To install, first clone the repository:

 	$ git clone https://github.com/rockwellct/edr_activity.git

then the gem can be built and installed locally

	$ bundle install
	$ gem build edr_activity.gemspec
	$ gem install edr_activity-<version number>.gem --no-doc

## Usage

This gem installs a simple command `eag` for executing the activity generator.

	$ eag <path to config file>

The configuration file defines the options for the activity generator, executing
separate runners to generate activity for processes, files, and network connections.

After each run, in the path defined in the configuration file, there will be a
log with information about every step taken by each runner during the run.

## Configuration

As referenced above, the behavior of the activity generator is controlled by a
configuration file, written in yaml format.  Sample configurations are available
in the [sample_configs](sample_configs/) folder.

The basic outline for a configuration file is as follows:

```yaml
output:
  path: <string>
  format: <string>
runners:
  process:
    - command: <string>
      arguments:
        - <string>
  file:
    path: <string>
    count: <integer>
    extension: <string>
  network:
    - address: <string>
      port: <integer>
      protocol: <string>
      message: <string>
```

Parameter | Description
--- | ---
`output.path` | The local path where the activity log should be generated
`output.format` | The format of the output log.  Currently only `json` is supported
`runners.process` | An array of commands to be run on the EDR host
`runners.process.command` | A string representing the command to execute
`runners.process.arguments` | An array of strings representing the arguments to pass to the command
`runners.file` | Settings for the file (create, modify, delete) activities
`runners.file.path` | The path where the files that are generated and modified will be located
`runners.file.count` | The count of files to create, modify, and delete
`runners.file.extension` | The extension to add to all files generated
`runners.network` | An array of hosts and information for testing network connections
`runners.network.address` | The IP address of the destination host
`runners.network.port` | The port on the destination host to contact
`runners.network.protocol` | The network protocol to use when sending the traffic, can be one of `udp, tcp`
`runners.network.message` | The content to send to the destination host


## Development

After checking out the repo, run `bundle install` to install dependencies.


## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/rockwellct/edr_activity.


## License

The gem is available as open source under the terms of the
[MIT License](https://opensource.org/licenses/MIT).
