# flutter_hades_core

Low-level functions for HADES/CHARON written in DART. Similar structure to [jnano-commons](https://github.com/rotilho/jnano-commons) for Java

Examples:

```
# Generate a random seed
String randomSeed = HadesSeeds.generateSeed();
# Validate a seed
bool seedIsValid = HadesSeeds.isValid(randomSeed);

# Create private key from seed at index 0
String privateKey = HadesKeys.seedToPrivate(seed, 0);
# Create public key from private key
String publicKey = HadesKeys.createPublicKey(privateKey);
# Create account from public get (hades_/charon_ address)
String address = HadesAccounts.createAccount(HadesAccountType.HADES, publicKey);

# Compute state block hash
computeStateHash(int accountType, String account, String previous, String representative, BigInt balance, String link);

# Sign a block
HadesSignatures.signBlock(hash, privateKey);
```