# nimaze

A maze generator built with nim.

## Installation
```
git clone https://github.com/lucantrop/nimaze
cd nimaze
nimble build
```
and
```
nim doc nimaze
```
for documentation.

## Usage
```
./nimaze -w 20 -h 20
________________________________________
| |  _  |_____   _  |_   _____  |   |   |
|___| |_________| |_____|  _____| | | | |
|   |     |  _|     |   |___  |_  |___| |
|_| | | |___|  _| | | | |  ___|  _|   | |
|  _| |___  |_  | |___|_|_  |  _____| |_|
|  ___| |  _|  _| |   |   | |_____  |_  |
|_  |_  | |  _| |___|___|___|_______|   |
| |_  | |___|   |___   _   _____  |  _| |
|  ___|  ___  | |   |_  | | |  ___| | | |
| |___  | |  _|___|_  |_| |_________|  _|
|___  |  _| |  _  | |_  | |  ___  |  _| |
|   | | |  _| |  _|  _| | | |  _| |___  |
| |_| |_| |  _|___  |  _|  _| |  _|_  | |
| |  _|  _| |   |___| |  _____| |  ___| |
| | |  _|   | |___  | | |  _  | | |   | |
| |___|  _|_| | |  _| |_|_  | | | | | | |
| |  _________| |_  |_  |  _|___| | |___|
| |___  |   |___  |_  |___|  ___  | |   |
|  _|  _| |_____  |  _|   | |  ___| |_| |
|_________|_______|_____|___|___________|
```

## Testing
Run the test suite with
```
nimble test_all
```

## TODO
* implement other algorithms
* implement different visualization methods
