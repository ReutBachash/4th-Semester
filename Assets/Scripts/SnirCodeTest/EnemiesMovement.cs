using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AI;

public class EnemiesMovement : MonoBehaviour
{
    [SerializeField] private NavMeshAgent EnemyAgent;
    [SerializeField] private Transform _target;
    [SerializeField] private Transform Player;


    private bool isStopped = false;

    private Animator animator;

    public float LookAtSpeed = 5f;

    public void Start()
    {
        EnemyAgent = GetComponent<NavMeshAgent>();
        animator = this.GetComponent<Animator>();
        DisablLookAtPlayer();

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
            animator.SetBool("Runing", false);
            animator.SetTrigger("Stop");
            EnableLookAtPlayer();
        }
        else
        {
            animator.SetBool("Runing", true);
            DisablLookAtPlayer();
        }
    }

    private void EnableLookAtPlayer()
    {
        gameObject.GetComponent<EnemiseLookPlayer>().enabled = true;
    }

    private void DisablLookAtPlayer()
    {
        gameObject.GetComponent<EnemiseLookPlayer>().enabled = false;
    }
}
