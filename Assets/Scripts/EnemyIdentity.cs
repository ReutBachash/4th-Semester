using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EnemyIdentity : MonoBehaviour
{

    public int _enemyNumber;
    public bool _isLastEnemy;
    public bool isAlive=false;

    [SerializeField] Shoot _shootScript;

    private void Start()
    {
        _shootScript.onEnemyDeath += Dead;

    }

    private void Dead(EnemyIdentity identity)
    {
        Debug.Log("Meow");
        isAlive = false;
        
    }
}
