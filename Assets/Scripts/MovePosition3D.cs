using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MovePosition3D : MonoBehaviour
{
    [SerializeField] private Camera mainCamera;
    [SerializeField] private LayerMask mouseColiderLayerMask;

    // Update is called once per frame
    void Update()
    {
        Ray ray = mainCamera.ScreenPointToRay(Input.mousePosition);
        if(Physics.Raycast(ray,out RaycastHit hit,999f,mouseColiderLayerMask))
        {
            transform.position = hit.point;
        }
    }
}
