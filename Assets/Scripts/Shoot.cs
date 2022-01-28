using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System;

public class Shoot : MonoBehaviour
{
    public float Range = 1000;
    public float Force = 1000;
    [SerializeField] private Camera mainCamera;
    [SerializeField] private LayerMask mouseColiderLayerMask;


    // Update is called once per frame
    void Update()
    {
        if (Input.GetMouseButtonDown(0))
            RayShoot();
    }

    void RayShoot()
    {
        Ray ray = mainCamera.ScreenPointToRay(Input.mousePosition);
        if (Physics.Raycast(ray, out RaycastHit hit, 200000f, mouseColiderLayerMask))
        {
            Debug.DrawLine(ray.origin, hit.point,Color.blue);
            if(hit.transform.CompareTag("Enemy"))
            {
                hit.transform.parent.GetComponentInChildren<Animator>().SetTrigger("Death");
                 Debug.Log("Hit");
            }

        }
    }
}
