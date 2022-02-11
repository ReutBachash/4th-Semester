using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System;
using UnityEngine.Events;

public class ZoneSequence : MonoBehaviour
{
    [SerializeField] AnimationHandler[] enemies;
    [SerializeField] float timeAlive;

    [HideInInspector]
    public UnityEvent AnimationZoneSequenceStart;
    [HideInInspector]
    public UnityEvent AnimationZoneSequenceStop;

    // Start is called before the first frame update
    private void Awake()
    {
        foreach(AnimationHandler e in enemies)
        {
            AnimationZoneSequenceStart.AddListener(e.AnimationStart);
            AnimationZoneSequenceStop.AddListener(e.AnimationStop);
        }
    }
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
