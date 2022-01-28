using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ExecutableScript : MonoBehaviour
{
    [SerializeField] ZoneSequence[] gameplayZones;
    [SerializeField] private float waitTime;
    [SerializeField] private int zoneNumber;
    // Start is called before the first frame update
    void Start()
    {
        StartCoroutine(ActivateSequnece(waitTime));
    }
    private IEnumerator ActivateSequnece(float waitTime)
    {
        foreach (ZoneSequence z in gameplayZones)
        {
            z.StartSequenceEvent();
            yield return new WaitForSeconds(z.GetTimeAlive());
            z.StopSequenceEvent();
            yield return new WaitForSeconds(waitTime);
        }
        EnableZoneClear();

    }

    private void EnableZoneClear()
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
