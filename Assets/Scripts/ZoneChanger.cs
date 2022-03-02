using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ZoneChanger : MonoBehaviour
{
    [SerializeField] private EnemiesSpawnLogic _zoneEnemySpawnScript;
    // Start is called before the first frame update

    private void Start()
    {
        _zoneEnemySpawnScript.onLastEnemykilledInZone += EnableZoneClear;
    }

    private void EnableZoneClear(int zoneNumber)
    {
        switch (zoneNumber)
        {
            case 1:
                GameObject.Find("CM vcam1").GetComponent<TriggerHandler>().zone1Cleared = true;
                break;
            case 2:
                GameObject.Find("CM vcam1").GetComponent<TriggerHandler>().zone2Cleared = true;
                break;
            case 3:
                GameObject.Find("CM vcam1").GetComponent<TriggerHandler>().zone3Cleared = true;
                break;

        }
    }

    }
