using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AI;

public class EnemiesMovement : MonoBehaviour
{
    [SerializeField] private NavMeshAgent EnemyAgent;
    [SerializeField] private Transform _target;

    public void Start()
    {
        EnemyAgent = GetComponent<NavMeshAgent>();
    }

    public void Update()
    {
        SetDestination();
    }

    [ContextMenu("Set Destination to Target")]
    public void SetDestination()
    {
        Debug.Log(EnemyAgent.SetDestination(_target.position));
    }
}
