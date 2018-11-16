#Samples

##Payers

```
{
  "$class": "org.uspc.pbnet.Payer",
  "payerKey": "UHG",
  "name": "United Health Group"
}

{
  "$class": "org.uspc.pbnet.Payer",
  "payerKey": "CIG",
  "name": "CIGNA"
}
```

##Claim

```
{
  "$class": "org.uspc.pbnet.Claim",
  "claimId": "1",
  "payer": "resource:org.uspc.pbnet.Payer#UHG",
  "patientId": "1",
  "patientName": "John",
  "value": 1110,
  "claimDate": "2018-11-10T11:21:40.401Z"
}
```

##ClaimTransaction

```
{
  "$class": "org.uspc.pbnet.ClaimTransaction",
  "claim": "resource:org.uspc.pbnet.Claim#1",
   "timestamp": "2018-11-10T11:21:40.869Z"
}
```
