rubypick
=========

Fedora /usr/bin/ruby stub to allow choosing Ruby runtime. Similarly to
[rbenv][1] or [RVM][2], it allows non-privileged user to choose which
is preferred Ruby runtime for current task.

Supported Runtimes
------------------

The following are supported runtimes under Fedora:

* Ruby - /usr/bin/ruby-mri
* JRuby - /usr/bin/jruby

Execution
--------------

To run a specific runtime, use:

```
ruby _mri_ [params]
ruby _jruby_ [params]
```

The default is \_mri\_.

To run Ruby executables with shebang, such as 'gem', you can also use these:

```
gem _mri_ install foo
gem _jruby_ install foo
```

Or you can set environment variable RUBYPICK like this:

```
RUBYPICK=_mri_
RUBYPICK=_jruby_
```

and then MRI, resp. JRuby will be used for all ruby invocations.
This is still overriden by using the parameter as mentioned above.

If you don't want to use rubypick, you can always fall back to
using the above binaries.

License
-------

Licensed under MIT License.



[1]: http://rbenv.org/
[2]: https://rvm.io/
