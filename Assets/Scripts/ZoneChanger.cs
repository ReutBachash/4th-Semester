using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Cinemachine;

public class ZoneChanger : MonoBehaviour
{
    [SerializeField] private EnemiesSpawnLogic _zoneEnemySpawnScript;
    // Start is called before the first frame update

    public CinemachineVirtualCamera camera;
    private bool move = false;
    private CinemachinePOV vCamPOV;
    [SerializeField] private float lerpDuration = 10;
    float timeElapsed;
    [SerializeField] private float sidePosition;

    private void Start()
    {
        _zoneEnemySpawnScript.onLastEnemykilledInZone += EnableZoneClear;

        vCamPOV = camera.GetCinemachineComponent<CinemachinePOV>();
        vCamPOV.m_HorizontalAxis.m_MinValue = -150;
        vCamPOV.m_HorizontalAxis.m_MaxValue = 0;
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
                move = true;

                break;

        }
    }
    private void Update()
    {
        if (move)
        {
            if (timeElapsed < lerpDuration)
            {
                vCamPOV.m_HorizontalAxis.Value = Mathf.Lerp(vCamPOV.m_HorizontalAxis.Value, sidePosition, timeElapsed / lerpDuration);
                vCamPOV.m_HorizontalAxis.m_MinValue = -150;
                vCamPOV.m_HorizontalAxis.m_MaxValue = 0;
                timeElapsed += Time.deltaTime;
                move = false;

            }

        }
    }
}