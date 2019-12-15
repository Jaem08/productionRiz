var solc = require('solc');
var fs = require('fs');

var inputFilePath = process.argv[2];
var outputPath = process.argv[3];

// note - using the synchronous version of the file system functions for simplicity and because the async version isn't really needed in this case
var contractSolidity = fs.readFileSync(inputFilePath , 'utf-8');
if (!contractSolidity)
    return console.error('unable to read file: ' + inputFilePath );

var output = solc.compile(contractSolidity, 1);
for (var contractName in output.contracts) {
    var abi = output.contracts[contractName].interface;
    var code = output.contracts[contractName].bytecode;
    fs.writeFileSync(outputPath + '/' + contractName + '.abi', abi, 'utf-8');
    fs.writeFileSync(outputPath + '/' + contractName + '.code', code, 'utf-8');
}
