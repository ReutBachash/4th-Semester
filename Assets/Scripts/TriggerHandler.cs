using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TriggerHandler : MonoBehaviour
{
    public bool zone1Cleared = false;
    public bool zone2Cleared = false;
    public bool zone3Cleared = false;

    private void Update()
    {
        ChangeZone();
    }

    private void ChangeZone()
    {
       if(zone1Cleared)
        {
            this.gameObject.GetComponent<Animator>().SetTrigger("Zone1Cleared");
        }
    }
}
