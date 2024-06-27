## VirtualAcousticOceans

### Debugging

To tail all the logs created by multiple instances of UnetStack..

```
tail -F $(find logs -name 'log-0.txt*' ! -name '*.lck')
```