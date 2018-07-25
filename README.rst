Renode Zephyr testing PoC
=========================

This simple repository shows how to use Renode and Robot to test Zephyr on a Mi-V platform in one failing and one successful scenario.

Prerequisites
-------------

* Zephyr SDK (needed for compiling failing test)
* Renode prerequisites: https://github.com/renode/renode#installation
* Robot and related packages, see http://renode.readthedocs.io/en/latest/advanced/building_from_sources.html#installing-python-modules  
* Renode (install from package using ``sudo dpkg -i renode_1.4.1+20180725git72cb11d_amd64.deb``)

Running
-------

.. code-block:: console

   ../test-miv.sh /opt/zephyr-sdk/

Results
-------

You should see a Zephyr compilation log, then a failing and a successful test execute.
There will be some windows opening (these can be supressed, TODO: describe how).

The results will be in ``log.html`` and ``report.html`` .
