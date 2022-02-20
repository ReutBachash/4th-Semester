using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AI;

public class EnemiesMovement : MonoBehaviour
{
    [SerializeField] private NavMeshAgent EnemyAgent;
    [SerializeField] private Transform _target;

    private bool isStopped = false;

    private Animator animator;

    public void Start()
    {
        EnemyAgent = GetComponent<NavMeshAgent>();
        animator = this.GetComponent<Animator>();
    }
    private void Update()
    {
        CheckRemainingDistance();
        //Debug.Log(EnemyAgent.remainingDistance);
    }
    [ContextMenu("Set Destination to Target")]
    public void SetDestination()
    {
        EnemyAgent.SetDestination(_target.position);
    }

    private void CheckRemainingDistance()
    {
        if (EnemyAgent.remainingDistance < 0.1f )
        {
            animator.SetTrigger("Stop");
        }


    }

}
