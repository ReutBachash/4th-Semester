using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System;
using UnityEngine.Events;

public class ZoneSequence : MonoBehaviour
{
    [SerializeField] UnityEvent AnimationZoneSequenceStart;
    [SerializeField] UnityEvent AnimationZoneSequenceStop;
    [SerializeField] float timeAlive;

    // Start is called before the first frame update

    public void StartSequenceEvent()
    {
        AnimationZoneSequenceStart.Invoke();
    } 
    public void StopSequenceEvent()
    {
        AnimationZoneSequenceStop.Invoke();
    }
    public float GetTimeAlive()
    {
        return timeAlive;
    }
}
