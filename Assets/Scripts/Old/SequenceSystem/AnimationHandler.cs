using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AnimationHandler : MonoBehaviour
{
    [SerializeField] private Animator animator;
    private void Awake()
    {
        animator = this.gameObject.GetComponent<Animator>();
    }
    public void AnimationStart()
    {
        animator.SetTrigger("Start");
    }
    public void AnimationStop()
    {
        animator.SetTrigger("Stop");
    }
}
