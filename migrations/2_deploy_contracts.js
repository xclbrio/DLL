const ExcaliburDLL = artifacts.require("ExcaliburDLL");
const ExcaliburEx = artifacts.require("ExcaliburEx");

module.exports = function(deployer) {
  deployer.deploy(ExcaliburDLL);
  deployer.link(ExcaliburDLL, ExcaliburEx);
  deployer.deploy(ExcaliburEx);
};
