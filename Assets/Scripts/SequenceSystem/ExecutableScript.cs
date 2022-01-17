using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ExecutableScript : MonoBehaviour
{
    [SerializeField] ZoneSequence[] gameplayZones;
    [SerializeField] private float waitTime;
    // Start is called before the first frame update
    void Start()
    {
        StartCoroutine(ActivateSequnece(waitTime));
    }
    private IEnumerator ActivateSequnece(float waitTime)
    {
        while (true)
        {
            foreach (ZoneSequence z in gameplayZones)
            {
                z.StartSequenceEvent();
                yield return new WaitForSeconds(z.GetTimeAlive());
                print("WaitAndPrint " + Time.time);
                z.StopSequenceEvent();
                yield return new WaitForSeconds(waitTime);
                print("WaitAndPrint " + Time.time);
            }
        }
    }
}
